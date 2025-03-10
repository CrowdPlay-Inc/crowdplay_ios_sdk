//
//  AppDelegate.swift
//  crowdplaysdk
//
//  Created by Matthew Baker on 02/09/2022.
//  Copyright (c) 2022 Matthew Baker. All rights reserved.
//

import UIKit
import crowdplaysdk
import os

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        UNUserNotificationCenter.current().delegate = self

        // UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) {
        //     granted, error in
        //     if granted {
        //         DispatchQueue.main.async { UIApplication.shared.registerForRemoteNotifications() }
        //     }
        // }

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        let log = OSLog(subsystem: "com.crowdplayapp.sdkexample", category: "network")
        os_log("didRegisterForRemoteNotificationsWithDeviceToken called", log: log, type: .info)

        CrowdplaySdk.shared.setNotificationToken(deviceToken: deviceToken)
    }

    @available(iOS 10.0, *)
    func userNotificationCenter(
        _ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        //OnTap Notification
        let userInfo = response.notification.request.content.userInfo
        print("userNotificationCenter center: response: completionHandler:")
        print(userInfo)
        if self.window?.rootViewController != nil {
            if let apiKey = UserDefaults.standard.string(forKey: "apiKey") {
                CrowdplaySdk.shared.initialize(apiKey: apiKey, appUrlScheme: "cpsdkdemopod")
            }

            if CrowdplaySdk.shared.handleNotification(
                userInfo: userInfo, vc: self.window!.rootViewController!)
            {
                print("Handled by Crowdplay")
            }
        }

        completionHandler()
    }

    func application(
        _ application: UIApplication, open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {
        let handled = CrowdplaySdk.shared.handleAppLink(appLink: url)
        if handled {
            return true
        }

        // Handle pass it down the line or handle within this app
        // .
        // .
        // .
        return false
    }

    func userNotificationCenter(
        _ center: UNUserNotificationCenter, willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) ->
            Void
    ) {
        // Display the notification as a banner and play sound
        if #available(iOS 14.0, *) {
            completionHandler([.banner, .sound])
        } else {
            completionHandler([.alert, .sound])
        }
    }
}
