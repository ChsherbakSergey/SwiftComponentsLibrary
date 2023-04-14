//  Created by Sergey Chsherbak on 14/04/2023.

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        window = UIWindow(windowScene: scene as! UIWindowScene)
        window?.rootViewController = UINavigationController(rootViewController: OutlineViewController())
        window?.makeKeyAndVisible()
    }
}
