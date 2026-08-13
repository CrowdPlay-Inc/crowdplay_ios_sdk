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
    @IBOutlet var ssoProviderPicker: UIPickerView?
    @IBOutlet var ssoTokenField: UITextField?

    private let ssoProviders = [
        ("nbaid", "NBA ID"),
        ("ticketmaster", "Ticketmaster"),
        ("yinzcam", "YinzCam"),
        ("auth0", "Auth0"),
    ]
    private var selectedProviderIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        overrideUserInterfaceStyle = .light

        ssoProviderPicker?.dataSource = self
        ssoProviderPicker?.delegate = self

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

        // Listen for auth state changes
        CrowdplaySdk.shared.onAuthStateChanged = { [weak self] state in
            DispatchQueue.main.async {
                self?.authStatusLabel?.text = "Auth Status: \(self?.authStateDescription(state) ?? state.rawValue)"
            }
        }

        // Listen for points balance changes
        CrowdplaySdk.shared.onPointsChanged = { [weak self] points in
            DispatchQueue.main.async {
                self?.userPointsLabel?.text = "Current User points: \(Int(points))"
            }
        }

        // Listen for loyalty code changes (rotating codes update every ~30s;
        // nil code = signed out). A host app would re-render its QR here.
        CrowdplaySdk.shared.onLoyaltyCodeChanged = { code, description in
            print("Loyalty code changed: \(code ?? "nil") (\(description ?? ""))")
        }

        UserDefaults.standard.set(apiKey, forKey: "apiKey")
        CrowdplaySdk.shared.presentCrowdplay(vc: self)

        // Load initial auth status
        Task {
            let isLoggedIn = try? await CrowdplaySdk.shared.loggedIn()
            await MainActor.run {
                if isLoggedIn == true {
                    authStatusLabel?.text = "Auth Status: Logged In"
                } else {
                    authStatusLabel?.text = "Auth Status: Logged Out"
                }
            }
        }
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

    @IBAction func ssoLoginTapped(_ sender: UIButton) {
        guard let token = ssoTokenField?.text, !token.isEmpty else { return }
        let provider = ssoProviders[selectedProviderIndex]
        authStatusLabel?.text = "Authenticating (\(provider.1))..."
        CrowdplaySdk.shared.setAuthToken(authToken: token, provider: provider.0) { [weak self] result in
            DispatchQueue.main.async {
                self?.handleAuthResult(result, provider: provider.1)
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

    private func authStateDescription(_ state: CrowdPlayAuthState) -> String {
        switch state {
        case .loggedIn: return "Logged In"
        case .loggedOut: return "Logged Out"
        case .authenticating: return "Authenticating..."
        case .loggingOut: return "Logging Out..."
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

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ssoProviders.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ssoProviders[row].1
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedProviderIndex = row
    }
}
