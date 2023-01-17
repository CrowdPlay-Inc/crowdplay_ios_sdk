import UIKit
import Flutter
// Used to connect plugins (only if you have plugins with iOS platform code).
import FlutterPluginRegistrant

public class CrowdplaySdk {
    public static let shared = CrowdplaySdk()
    lazy var flutterEngine = FlutterEngine(name: "CrowdPlay Flutter engine")
    var flutterViewController: FlutterViewController?
    private var apiKey = ""

    private init() {}

    public func initialize(apiKey: String) {
        self.apiKey = apiKey;
        
        flutterEngine.run();
        
        let apiKeyChannel = FlutterMethodChannel(name: "crowdplay.flutter", binaryMessenger: flutterEngine.binaryMessenger)
        apiKeyChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
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
}

