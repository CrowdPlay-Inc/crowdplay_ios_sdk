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
    var showVenueNextWalletHandler: (() -> Void)?

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
                showVenueNextWalletHandler?();
                result(true)
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

    public func presentCrowdplay(vc: UIViewController) {
        guard let toDisplay = self.viewController() else {
            print("CrowdPlay SDK has not yet been initialized")
            return
        }

        if presentingViewController?.presentedViewController == toDisplay {
            print("Already presented")
            return
        }

        if presentingViewController != nil && presentingViewController != vc {
            DispatchQueue.main.async {
                self.flutterViewController?.dismiss(animated: false)
            }
        }

        presentingViewController = vc
        DispatchQueue.main.async {
            vc.present(toDisplay, animated: true, completion: nil)
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

        if vc != nil {
            self.presentCrowdplay(vc: vc!)
        }

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

    public func setAuthToken(authToken: String, provider: String) {
        self.authToken = ["token": authToken, "provider": provider]

        if apiKeyChannel != nil {
            apiKeyChannel!.invokeMethod("performTokenLogin", arguments: self.authToken)
        }
    }

    public func linkAccount(providerToken: String, provider: String) {
        var providerInfo: [String: String] = ["token": providerToken, "provider": provider]
        self.linkedAccounts.append(providerInfo)

        if apiKeyChannel != nil {
            apiKeyChannel!.invokeMethod(
                "linkAccounts", arguments: ["accounts": self.linkedAccounts])
        }
    }

    public func handleAppLink(appLink: URL) -> Bool {
        if apiKeyChannel == nil || (appLink.host != "crowdplay" && appLink.host != "rtl-callback") {
            return false
        }

        apiKeyChannel!.invokeMethod("handleAppLink", arguments: appLink.absoluteString)

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
