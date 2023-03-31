import UIKit
import Flutter
// Used to connect plugins (only if you have plugins with iOS platform code).
import FlutterPluginRegistrant

public class CrowdplaySdk {
    public static let shared = CrowdplaySdk()
    lazy var flutterEngine = FlutterEngine(name: "CrowdPlay Flutter engine")
    private var apiKeyChannel: FlutterMethodChannel?
    var flutterViewController: FlutterViewController?
    private var apiKey = ""
    private var notificationToken = "";

    private init() {}

    public func initialize(apiKey: String) {
        self.apiKey = apiKey;
        
        flutterEngine.run();
        
        apiKeyChannel = FlutterMethodChannel(name: "crowdplay.flutter", binaryMessenger: flutterEngine.binaryMessenger)
        apiKeyChannel!.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
            if call.method == "initialization" {
              result(self.apiKey)
            } else if call.method == "CLOSE_CROWDPLAY" {
                self.flutterViewController?.dismiss(animated: true);
            } else if call.method == "getNativeNotificationToken" {
                result(self.notificationToken);
            }
        }
        // Used to connect plugins (only if you have plugins with iOS platform code).
        GeneratedPluginRegistrant.register(with: self.flutterEngine);
    }
    
    public func viewController() -> FlutterViewController {
        if (flutterViewController != nil) {
            return flutterViewController!;
        }

        flutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
        flutterViewController?.modalPresentationStyle = .fullScreen
        return flutterViewController!
    }

    public func presentCrowdplay(vc: UIViewController) {
        vc.present(viewController(), animated: true, completion: nil)
    }

    public func handleNotification(userInfo: [AnyHashable : Any]?, vc: UIViewController) -> Bool {
        print("handleNotification" + (userInfo?.description ?? ""));
        if userInfo == nil || apiKeyChannel == nil {
            print("No userInfo or apiKeyChannel");
            return false
        }
        if userInfo!["custom"] == nil {
            print("Source is not crowdplay 1");
            return false
        }

        if userInfo!["custom"] as? Dictionary<AnyHashable, Any> == nil {
            print("Source is not crowdplay 2");
            return false
        }
        
        let custom = userInfo!["custom"] as! Dictionary<AnyHashable, Any>;
        
        if custom["a"] as? Dictionary<AnyHashable, Any> == nil {
            print("Source is not crowdplay 3");
            return false
        }
        
        let customApns = custom["a"] as! Dictionary<AnyHashable, Any>;
        
        if customApns["source"] as? String == nil {
            print("Source is not crowdplay 4");
            return false
        }
        
        let source = customApns["source"] as! String;
        
        if source != "crowdplay" {
            print("Source is not crowdplay 5");
            return false
        }

        self.presentCrowdplay(vc: vc);
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.apiKeyChannel!.invokeMethod("handleNotification", arguments: customApns);
        }

        return true
    }

    public func setNotificationToken(deviceToken: Data) {
        let tokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})

        self.notificationToken = tokenString;
        print("Device Token: " + tokenString);

        apiKeyChannel!.invokeMethod("setNotificationToken", arguments: tokenString);
    }
}

