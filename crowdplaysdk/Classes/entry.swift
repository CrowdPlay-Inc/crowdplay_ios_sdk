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

    public func handleNotification(userInfo: [AnyHashable : Any]?) -> Bool {
        if userInfo == nil || apiKeyChannel == nil {
            return false
        }

        if userInfo!["source"] == nil || userInfo!["source"] as? String == nil || userInfo!["source"] as! String != "crowdplay" {
            return false
        }

        apiKeyChannel!.invokeMethod("handleNotification", arguments: userInfo);

        return true
    }
}

