import Flutter
// Used to connect plugins (only if you have plugins with iOS platform code).
import FlutterPluginRegistrant
import UIKit
import os

extension UIDevice {
    fileprivate enum PushEnvironment: String {
        case unknown
        case development
        case production
    }

    fileprivate var pushEnvironment: PushEnvironment {
        guard let provisioningProfile = try? provisioningProfile(),
            let entitlements = provisioningProfile["Entitlements"] as? [String: Any],
            let environment = entitlements["aps-environment"] as? String
        else {
            return .unknown
        }

        return PushEnvironment(rawValue: environment) ?? .unknown
    }

    // MARK: - Private

    private func provisioningProfile() throws -> [String: Any]? {
        guard let url = Bundle.main.url(forResource: "embedded", withExtension: "mobileprovision")
        else {
            return nil
        }

        let binaryString = try String(contentsOf: url, encoding: .isoLatin1)

        let scanner = Scanner(string: binaryString)
        guard scanner.scanUpToString("<plist") != nil,
            let plistString = scanner.scanUpToString("</plist>"),
            let data = (plistString + "</plist>").data(using: .isoLatin1)
        else {
            return nil
        }

        return try PropertyListSerialization.propertyList(from: data, options: [], format: nil)
            as? [String: Any]
    }
}

public class CrowdplaySdk {
    public static let shared = CrowdplaySdk()
    lazy var flutterEngine = FlutterEngine(name: "CrowdPlay Flutter engine")
    private var apiKeyChannel: FlutterMethodChannel?
    var flutterViewController: FlutterViewController?
    private var apiKey = ""
    private var notificationToken = ""
    private var authToken: [String: String] = [:]
    private var linkedAccounts: [[String: String]] = []
    private var appUrlScheme = ""
    private var presentingViewController: UIViewController?
    public var showVenueNextWalletHandler: (() -> Void)?
    public var onAuthStateChanged: ((CrowdPlayAuthState) -> Void)?
    public var onPointsChanged: ((Double) -> Void)?
    /// Fired whenever the user's loyalty code changes (nil = signed out).
    public var onLoyaltyCodeChanged: ((String?, String?) -> Void)?
    private var pendingAuthCompletion: ((CrowdPlayAuthResult) -> Void)?
    private var tokenRefreshHandler: (() async -> (token: String, provider: String)?)?

    /// Invoked whenever the SDK needs to surface its UI — either because
    /// the host called `presentCrowdplay(vc:)` directly, or because a
    /// notification / deep link arrived that should bring CrowdPlay to
    /// the foreground.
    ///
    /// When this handler is set, the SDK will NOT auto-present. The host
    /// app is responsible for making the SDK's surface visible —
    /// typically by switching to the tab/view that embeds
    /// `viewController()`. When this handler is `nil`, the SDK falls back
    /// to the legacy behavior of presenting the FlutterViewController
    /// modally over the supplied view controller.
    public var onPresentRequested: (() -> Void)?

    private init() {}

    public var isInitialized: Bool {
        return self.apiKeyChannel != nil
    }

    public func initialize(apiKey: String, appUrlScheme: String) {
        if apiKey == "" || appUrlScheme == "" {
            fatalError("apiKey and appUrlScheme are required")
        }
        if self.apiKey != "" {
            print("CrowdPlay has already been initialized")
            return
        }

        self.apiKey = apiKey
        self.appUrlScheme = appUrlScheme

        flutterEngine.run()

        apiKeyChannel = FlutterMethodChannel(
            name: "crowdplay.flutter", binaryMessenger: flutterEngine.binaryMessenger)
        apiKeyChannel!.setMethodCallHandler {
            (call: FlutterMethodCall, result: @escaping FlutterResult) in
            if call.method == "initialization" {
                result(self.apiKey)
            } else if call.method == "CLOSE_CROWDPLAY" {
                self.flutterViewController?.dismiss(animated: true)
                self.presentingViewController = nil
            } else if call.method == "getNativeNotificationToken" {
                if self.notificationToken == "" {
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                }
                result(self.notificationToken)
            } else if call.method == "getApnsMode" {
                result(
                    UIDevice.current.pushEnvironment == .development ? "development" : "production")
            } else if call.method == "getAuthToken" {
                result(self.authToken)
            } else if call.method == "getLinkedAccounts" {
                result(self.linkedAccounts)
            } else if call.method == "getUrlScheme" {
                result(self.appUrlScheme)
            } else if call.method == "showVenueNextWallet" {
                self.showVenueNextWalletHandler?();
                result(true)
            } else if call.method == "authResult" {
                if let args = call.arguments as? [String: Any] {
                    let authResult = CrowdPlayAuthResult(
                        success: args["success"] as? Bool ?? false,
                        method: args["method"] as? String,
                        error: args["error"] as? String,
                        errorCode: args["errorCode"] as? String
                    )
                    self.pendingAuthCompletion?(authResult)
                    self.pendingAuthCompletion = nil
                }
                result(nil)
            } else if call.method == "requestFreshToken" {
                guard let handler = self.tokenRefreshHandler else {
                    result(nil)
                    return
                }
                Task {
                    if let freshToken = await handler() {
                        result(["token": freshToken.token, "provider": freshToken.provider])
                    } else {
                        result(nil)
                    }
                }
            } else if call.method == "onAuthStateChanged" {
                if let args = call.arguments as? [String: Any],
                   let stateStr = args["state"] as? String,
                   let state = CrowdPlayAuthState(rawValue: stateStr) {
                    self.onAuthStateChanged?(state)
                }
                result(nil)
            } else if call.method == "onPointsChanged" {
                if let args = call.arguments as? [String: Any],
                   let points = args["points"] as? Double {
                    self.onPointsChanged?(points)
                }
                result(nil)
            } else if call.method == "onLoyaltyCodeChanged" {
                let args = call.arguments as? [String: Any]
                self.onLoyaltyCodeChanged?(
                    args?["code"] as? String,
                    args?["description"] as? String
                )
                result(nil)
            }
        }
        // Used to connect plugins (only if you have plugins with iOS platform code).
        GeneratedPluginRegistrant.register(with: self.flutterEngine)
    }

    public func viewController() -> FlutterViewController? {
        if !isInitialized {
            return nil
        }

        if flutterViewController != nil {
            return flutterViewController!
        }

        flutterEngine.isGpuDisabled = false
        flutterViewController = FlutterViewController(
            engine: flutterEngine, nibName: nil, bundle: nil)
        flutterViewController?.modalPresentationStyle = .fullScreen
        return flutterViewController!
    }

    /// Public entry point for "make CrowdPlay visible now." Routes
    /// through `onPresentRequested` if the host has set one (embedded
    /// integration); otherwise presents the FlutterViewController
    /// modally over `vc` (default fullscreen).
    public func presentCrowdplay(vc: UIViewController) {
        requestPresent(vc: vc)
    }

    /// Single funnel for all SDK-initiated "show me now" requests
    /// (direct `presentCrowdplay`, notification arrival, deep-link
    /// arrival). Hands off to `onPresentRequested` when set;
    /// auto-presents over `vc` otherwise. `vc` is unused when a
    /// handler is set, so callers that arrive without one (e.g. an
    /// `onPresentRequested`-only embedded integration responding to a
    /// notification with no presenter) can pass `nil`.
    private func requestPresent(vc: UIViewController?) {
        if let handler = onPresentRequested {
            handler()
            return
        }

        guard let presenter = vc else {
            print("CrowdPlay: no presenter view controller and no onPresentRequested handler — nothing to present from")
            return
        }

        guard let toDisplay = self.viewController() else {
            print("CrowdPlay SDK has not yet been initialized")
            return
        }

        if presentingViewController?.presentedViewController == toDisplay {
            print("Already presented")
            return
        }

        if presentingViewController != nil && presentingViewController != presenter {
            DispatchQueue.main.async {
                self.flutterViewController?.dismiss(animated: false)
            }
        }

        presentingViewController = presenter
        DispatchQueue.main.async {
            presenter.present(toDisplay, animated: true, completion: nil)
        }
    }

    public func handleNotification(userInfo: [AnyHashable: Any]?, vc: UIViewController?) -> Bool {
        if !isInitialized {
            return false
        }

        print("handleNotification" + (userInfo?.description ?? ""))
        if userInfo == nil || apiKeyChannel == nil {
            print("No userInfo or apiKeyChannel")
            return false
        }
        if userInfo!["custom"] == nil {
            print("Source is not crowdplay 1")
            return false
        }

        if userInfo!["custom"] as? [AnyHashable: Any] == nil {
            print("Source is not crowdplay 2")
            return false
        }

        let custom = userInfo!["custom"] as! [AnyHashable: Any]

        if custom["a"] as? [AnyHashable: Any] == nil {
            print("Source is not crowdplay 3")
            return false
        }

        let customApns = custom["a"] as! [AnyHashable: Any]

        if customApns["source"] as? String == nil {
            print("Source is not crowdplay 4")
            return false
        }

        let source = customApns["source"] as! String

        if source != "crowdplay" {
            print("Source is not crowdplay 5")
            return false
        }

        // Route through the same funnel as a direct presentCrowdplay
        // call. If the host has set onPresentRequested, the handler runs
        // and `vc` is ignored; otherwise we fall back to the legacy
        // behavior of presenting modally over `vc` (a no-op when `vc`
        // is nil and no handler is set).
        requestPresent(vc: vc)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.apiKeyChannel!.invokeMethod("handleNotification", arguments: customApns)
        }

        return true
    }

    public func setNotificationToken(deviceToken: Data) {
        let tokenString = deviceToken.reduce("", { $0 + String(format: "%02X", $1) })

        self.notificationToken = tokenString

        let log = OSLog(subsystem: "com.crowdplayapp.sdkexample", category: "network")
        os_log("Received device token: %@", log: log, type: .info, tokenString)
        print("Device Token: " + tokenString)

        if apiKeyChannel == nil {
            return
        }

        apiKeyChannel!.invokeMethod("setNotificationToken", arguments: tokenString)
    }

    public func setAuthToken(authToken: String, provider: String, completion: ((CrowdPlayAuthResult) -> Void)? = nil) {
        self.authToken = ["token": authToken, "provider": provider]
        self.pendingAuthCompletion = completion

        if apiKeyChannel != nil {
            apiKeyChannel!.invokeMethod("performTokenLogin", arguments: self.authToken)
        }
    }

    public func logout(completion: @escaping (Bool) -> Void) {
        guard let channel = apiKeyChannel else {
            completion(false)
            return
        }
        channel.invokeMethod("performLogout", arguments: nil) { result in
            completion(result as? Bool ?? false)
        }
    }

    public func setTokenRefreshHandler(_ handler: @escaping () async -> (token: String, provider: String)?) {
        self.tokenRefreshHandler = handler
    }

    public func linkAccount(providerToken: String, provider: String) {
        var providerInfo: [String: String] = ["token": providerToken, "provider": provider]
        self.linkedAccounts.append(providerInfo)

        if apiKeyChannel != nil {
            apiKeyChannel!.invokeMethod(
                "linkAccounts", arguments: ["accounts": self.linkedAccounts])
        }
    }

    /// Handle an inbound deep link. If the link is a CrowdPlay link, the
    /// SDK forwards it to Flutter and then surfaces its UI by routing
    /// through the same funnel as `presentCrowdplay(vc:)` — either via
    /// `onPresentRequested` (embedded integrations) or by presenting
    /// modally over `vc` (fullscreen integrations).
    ///
    /// Breaking change from earlier SDK versions: `vc` is now required.
    /// Earlier versions only forwarded the link to Flutter and never
    /// surfaced the SDK UI on their own; pass the view controller you
    /// want CrowdPlay to be presented from (typically the app's
    /// rootViewController).
    public func handleAppLink(appLink: URL, vc: UIViewController) -> Bool {
        if apiKeyChannel == nil || (appLink.host != "crowdplay" && appLink.host != "rtl-callback") {
            return false
        }

        apiKeyChannel!.invokeMethod("handleAppLink", arguments: appLink.absoluteString)

        // Match Android: after a short delay (let Flutter ingest the
        // link), bring CrowdPlay to the foreground via the standard
        // present funnel.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.requestPresent(vc: vc)
        }

        return true
    }

    public func loggedIn() async throws -> Bool? {
        if apiKeyChannel == nil {
            return nil
        }

        return try await withCheckedThrowingContinuation { continuation in
            apiKeyChannel!.invokeMethod("loggedIn", arguments: nil) { result in
                if let boolValue = result as? Bool {
                    continuation.resume(returning: boolValue)
                } else {
                    continuation.resume(returning: nil)
                }
            }
        }
    }

    public func getPointsBalance() async throws -> Int? {
        if apiKeyChannel == nil {
            return nil
        }

        return try await withCheckedThrowingContinuation { continuation in
            apiKeyChannel!.invokeMethod("getPointsBalance", arguments: nil) { result in
                if let intValue = result as? Int {
                    continuation.resume(returning: intValue)
                } else if let number = result as? NSNumber {
                    continuation.resume(returning: number.intValue)
                } else {
                    continuation.resume(returning: nil)
                }
            }
        }
    }

    public func getLoyaltyCodeAndDescription() async throws -> [String: String]? {
        if apiKeyChannel == nil {
            return nil
        }

        return try await withCheckedThrowingContinuation { continuation in
            apiKeyChannel!.invokeMethod("getLoyaltyCodeAndDescription", arguments: nil) { result in
                if let dictValue = result as? [String: String]? {
                    continuation.resume(returning: dictValue)
                } else {
                    continuation.resume(returning: nil)
                }
            }
        }
    }
}

public struct CrowdPlayAuthResult {
    public let success: Bool
    public let method: String?     // "login" or "register"
    public let error: String?      // Error message if failed
    public let errorCode: String?  // "token_expired", "token_invalid", "network_error", etc.
}

public enum CrowdPlayAuthState: String {
    case loggedIn
    case loggedOut
    case authenticating
    case loggingOut
}
