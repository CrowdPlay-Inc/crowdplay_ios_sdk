import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private var launchOptions: UIScene.ConnectionOptions?

    func scene(
        _ scene: UIScene, willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        launchOptions = connectionOptions
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Present cold-start links and notifications after the storyboard window is visible.
        guard let options = launchOptions, let presenter = window?.rootViewController else { return }
        launchOptions = nil
        forward(options.urlContexts)
        if let response = options.notificationResponse {
            (UIApplication.shared.delegate as? AppDelegate)?.handleNotification(
                userInfo: response.notification.request.content.userInfo, presenter: presenter)
        }
    }

    func scene(_ scene: UIScene, openURLContexts contexts: Set<UIOpenURLContext>) {
        forward(contexts)
    }

    private func forward(_ contexts: Set<UIOpenURLContext>) {
        guard let presenter = window?.rootViewController else { return }
        for context in contexts {
            (UIApplication.shared.delegate as? AppDelegate)?.handleAppLink(context.url, presenter: presenter)
        }
    }
}
