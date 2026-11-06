//
//  ViewController.swift
//  crowdplaysdk
//
//  Created by Matthew Baker on 02/09/2022.
//  Copyright (c) 2022 Matthew Baker. All rights reserved.
//

import CoreImage
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
    @IBOutlet private var qrImageView: UIImageView!

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
        guard initializeSdk() else { return }
        CrowdplaySdk.shared.presentCrowdplay(vc: self)
    }

    @IBAction func launchCrowdplayTabsTapped(_ sender: UIButton) {
        guard initializeSdk(), let crowdplay = CrowdplaySdk.shared.viewController() else { return }
        let tabs = CrowdplayTabsController(crowdplay: crowdplay)
        let navigation = UINavigationController(rootViewController: tabs)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true)
    }

    private func initializeSdk() -> Bool {
        guard let apiKey = apiKeyInput?.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              !apiKey.isEmpty else { return false }

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

        // Loyalty code changes (nil = signed out); a host would re-render its QR.
        CrowdplaySdk.shared.onLoyaltyCodeChanged = { [weak self] code, _ in
            DispatchQueue.main.async {
                self?.qrImageView.image = code.flatMap(Self.qrImage(from:))
            }
        }

        UserDefaults.standard.set(apiKey, forKey: "apiKey")

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
        return true
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

    private static func qrImage(from string: String) -> UIImage? {
        guard let data = string.data(using: .ascii),
            let filter = CIFilter(name: "CIQRCodeGenerator")
        else { return nil }
        filter.setValue(data, forKey: "inputMessage")
        guard let output = filter.outputImage else { return nil }
        return UIImage(ciImage: output.transformed(by: CGAffineTransform(scaleX: 8, y: 8)))
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

private final class CrowdplayTabsController: UITabBarController {
    private let crowdplay: UIViewController

    init(crowdplay: UIViewController) {
        self.crowdplay = crowdplay
        super.init(nibName: nil, bundle: nil)
        title = "Tabbed Example"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done, target: self, action: #selector(closeExample))

        let home = UIViewController()
        home.view.backgroundColor = .systemBackground
        home.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        let label = UILabel()
        label.text = "This is a native Home tab. Switch to CrowdPlay to use the embedded SDK."
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        home.view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: home.view.safeAreaLayoutGuide.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: home.view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            label.trailingAnchor.constraint(equalTo: home.view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
        ])

        let crowdplayTab = UIViewController()
        crowdplayTab.view.backgroundColor = .systemBackground
        crowdplayTab.tabBarItem = UITabBarItem(
            title: "CrowdPlay", image: UIImage(systemName: "sportscourt"), tag: 1)
        crowdplayTab.addChild(crowdplay)
        crowdplay.view.translatesAutoresizingMaskIntoConstraints = false
        crowdplayTab.view.addSubview(crowdplay.view)
        // Size Flutter's viewport above the native bars, even when its content draws edge to edge.
        let safeArea = crowdplayTab.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            crowdplay.view.topAnchor.constraint(equalTo: safeArea.topAnchor),
            crowdplay.view.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            crowdplay.view.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            crowdplay.view.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
        ])
        crowdplay.didMove(toParent: crowdplayTab)
        setViewControllers([home, crowdplayTab], animated: false)
        selectedIndex = 1
        CrowdplaySdk.shared.onPresentRequested = { [weak self] in
            DispatchQueue.main.async { self?.selectedIndex = 1 }
        }
        assert(crowdplay.parent === crowdplayTab)
    }

    required init?(coder: NSCoder) {
        fatalError("Use init(crowdplay:)")
    }

    @objc private func closeExample() {
        dismiss(animated: true)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        guard isBeingDismissed || navigationController?.isBeingDismissed == true
            || navigationController?.presentingViewController == nil else { return }
        CrowdplaySdk.shared.onPresentRequested = nil
        // Release the SDK controller from its tab before another full-screen or tabbed launch.
        crowdplay.willMove(toParent: nil)
        crowdplay.view.removeFromSuperview()
        crowdplay.removeFromParent()
        crowdplay.view.translatesAutoresizingMaskIntoConstraints = true
        setViewControllers(nil, animated: false)
        assert(crowdplay.parent == nil)
    }
}
