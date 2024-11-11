//
//  ViewController.swift
//  crowdplaysdk
//
//  Created by Matthew Baker on 02/09/2022.
//  Copyright (c) 2022 Matthew Baker. All rights reserved.
//

import UIKit
import crowdplaysdk

class ViewController: UIViewController {
    @IBOutlet var apiKeyInput: UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let apiKey = UserDefaults.standard.string(forKey: "apiKey") {
            apiKeyInput?.text = apiKey
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func launchCrowdplayTapped(_ sender: UIButton) {
        guard let apiKey = apiKeyInput?.text else { return ;}
        
        // Override point for customization after application launch.
        CrowdplaySdk.shared.initialize(apiKey: apiKey, appUrlScheme: "cpsdkdemopod")
        UserDefaults.standard.set(apiKey, forKey: "apiKey")
        CrowdplaySdk.shared.presentCrowdplay(vc: self)
        
        // print("Setting up background worker")
        // DispatchQueue.global().asyncAfter(deadline: .now() + 5.0) {
        //     if UIApplication.shared.windows.first?.rootViewController == nil {
        //         print("Root view controller is nil")
        //         return
        //     }
            
        //     var userInfo: [AnyHashable: Any] = [:]
        //     var custom: [AnyHashable: Any] = [:]
        //     var a: [AnyHashable: Any] = [:]
        //     a["source"] = "crowdplay"
        //     custom["a"] = a
        //     userInfo["custom"] = custom
            
        //     let result = CrowdplaySdk.shared.handleNotification(userInfo: userInfo, vc: UIApplication.shared.windows.first!.rootViewController!)
        //     print(result)
        // }
    }
}

