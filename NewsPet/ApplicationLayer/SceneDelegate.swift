//
//  SceneDelegate.swift
//  NewsPet
//
//  Created by Damir Yackupov on 23.09.2022.
//

import UIKit
import UISystem

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        setup(window)
        updateTheme()
    }
    
    func windowScene(_ windowScene: UIWindowScene, didUpdate previousCoordinateSpace: UICoordinateSpace, interfaceOrientation previousInterfaceOrientation: UIInterfaceOrientation, traitCollection previousTraitCollection: UITraitCollection) {
        updateTheme()
    }

    private func setup(_ window: UIWindow?) {
        let configurator = NewsListFactory()
        let vc = configurator.create()
        let nc = UINavigationController(navigationBarClass: NavigationBar.self, toolbarClass: nil)
        (nc.navigationBar as? NavigationBar)?.applyStyle(.basic)
        nc.viewControllers = [vc]
        window?.rootViewController = nc
        window?.makeKeyAndVisible()
    }
    
    private func updateTheme() {
        switch UITraitCollection.current.userInterfaceStyle {
        case .dark:
            ThemeManager.shared.update(theme: ThemeMainDark())
        default:
            ThemeManager.shared.update(theme: ThemeMainLight())
        }
    }
}

