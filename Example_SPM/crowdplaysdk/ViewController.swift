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
    @IBOutlet var userPointsLabel: UILabel?
    @IBOutlet var authStatusLabel: UILabel?
    @IBOutlet var nbaIdField: UITextField?
    @IBOutlet var tmTokenField: UITextField?
    @IBOutlet var yinzcamTokenField: UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let apiKey = UserDefaults.standard.string(forKey: "apiKey") {
            apiKeyInput?.text = apiKey
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func launchCrowdplayTapped(_ sender: UIButton) {
        guard let apiKey = apiKeyInput?.text, !apiKey.isEmpty else { return }

        CrowdplaySdk.shared.initialize(apiKey: apiKey, appUrlScheme: "cpsdkdemopod")

        CrowdplaySdk.shared.showVenueNextWalletHandler = {
            print("showVenueNextWalletHandler called")
        }

        // Set up token refresh handler for SSO retry
        CrowdplaySdk.shared.setTokenRefreshHandler {
            // In a real app, this would refresh the token from the SSO provider.
            // For the example, we return nil to indicate no fresh token is available.
            print("Token refresh requested by SDK")
            return nil
        }

        UserDefaults.standard.set(apiKey, forKey: "apiKey")
        CrowdplaySdk.shared.presentCrowdplay(vc: self)
    }

    @IBAction func updatePointsTapped(_ sender: UIButton) {
        Task {
            do {
                let result = try await CrowdplaySdk.shared.getPointsBalance() ?? 0
                userPointsLabel?.text = "Current User points: \(result)"
            } catch {
                userPointsLabel?.text = "Current User points: Error"
            }
        }
    }

    @IBAction func nbaIdLoginTapped(_ sender: UIButton) {
        guard let encryptedId = nbaIdField?.text, !encryptedId.isEmpty else { return }
        authStatusLabel?.text = "Authenticating (NBA ID)..."
        CrowdplaySdk.shared.setAuthToken(authToken: encryptedId, provider: "nbaid") { [weak self] result in
            DispatchQueue.main.async {
                self?.handleAuthResult(result, provider: "NBA ID")
            }
        }
    }

    @IBAction func tmLoginTapped(_ sender: UIButton) {
        guard let token = tmTokenField?.text, !token.isEmpty else { return }
        authStatusLabel?.text = "Authenticating (Ticketmaster)..."
        CrowdplaySdk.shared.setAuthToken(authToken: token, provider: "ticketmaster") { [weak self] result in
            DispatchQueue.main.async {
                self?.handleAuthResult(result, provider: "Ticketmaster")
            }
        }
    }

    @IBAction func yinzcamLoginTapped(_ sender: UIButton) {
        guard let token = yinzcamTokenField?.text, !token.isEmpty else { return }
        authStatusLabel?.text = "Authenticating (YinzCam)..."
        CrowdplaySdk.shared.setAuthToken(authToken: token, provider: "yinzcam") { [weak self] result in
            DispatchQueue.main.async {
                self?.handleAuthResult(result, provider: "YinzCam")
            }
        }
    }

    @IBAction func logoutTapped(_ sender: UIButton) {
        authStatusLabel?.text = "Logging out..."
        CrowdplaySdk.shared.logout { [weak self] success in
            DispatchQueue.main.async {
                self?.authStatusLabel?.text = success ? "Logged out" : "Logout failed"
            }
        }
    }

    private func handleAuthResult(_ result: CrowdPlayAuthResult, provider: String) {
        if result.success {
            authStatusLabel?.text = "\(provider): \(result.method ?? "success")"
        } else {
            authStatusLabel?.text = "\(provider) failed: \(result.error ?? "Unknown error") [\(result.errorCode ?? "")]"
        }
    }
}
