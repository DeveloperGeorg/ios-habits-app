//
//  SceneDelegate.swift
//  Habits
//
//  Created by Георгий Бондаренко on 11.12.2021.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        let tabBarController = UITabBarController()
        
        let habitsNavigationController = UINavigationController()
        habitsNavigationController.navigationBar.prefersLargeTitles = true
        habitsNavigationController.navigationBar.tintColor = ColorKit.systemPurple
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]

        habitsNavigationController.navigationBar.tintColor = ColorKit.systemPurple
        habitsNavigationController.navigationBar.standardAppearance = appearance
        habitsNavigationController.navigationBar.compactAppearance = appearance
        habitsNavigationController.navigationBar.scrollEdgeAppearance = appearance
        
        
        let habitsViewController = HabitsViewController()
        habitsNavigationController.pushViewController(habitsViewController, animated: false)
        habitsNavigationController.tabBarItem = UITabBarItem(
            title: "Привычки",
            image: UIImage(systemName: "rectangle.grid.1x2.fill")?.withTintColor(.gray, renderingMode: .alwaysOriginal),
            selectedImage: UIImage(systemName: "rectangle.grid.1x2.fill")?.withTintColor(.purple, renderingMode: .alwaysOriginal)
        )
        
        let infoNavigationController = UINavigationController()
        let infoViewController = InfoViewController()
        infoNavigationController.pushViewController(infoViewController, animated: false)
        infoNavigationController.tabBarItem = UITabBarItem(
            title: "Информация",
            image: UIImage(systemName: "info.circle")?.withTintColor(.gray, renderingMode: .alwaysOriginal),
            selectedImage: UIImage(systemName: "info.circle")?.withTintColor(.purple, renderingMode: .alwaysOriginal)
        )
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.purple], for: .selected)
        tabBarController.setViewControllers([
            habitsNavigationController,
            infoNavigationController
        ], animated: false)
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        self.window = window
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach{ addSubview($0) }
    }
    func activateConstraints(_ constraints: [NSLayoutConstraint]) -> Void {
        NSLayoutConstraint.activate(constraints)
    }
}

extension UIViewController {
    func addSubviews(_ views: [UIView]) {
        views.forEach{ view.addSubview($0) }
    }
    func activateConstraints(_ constraints: [NSLayoutConstraint]) -> Void {
        NSLayoutConstraint.activate(constraints)
    }
}

extension UINavigationController {
    func popBack(_ nb: Int) {
        let viewControllers: [UIViewController] = self.viewControllers
        guard viewControllers.count < nb else {
            self.popToViewController(viewControllers[viewControllers.count - nb], animated: true)
            return
        }
    }
 }
extension String: LocalizedError {
    public var errorDescription: String? { return self }
}
