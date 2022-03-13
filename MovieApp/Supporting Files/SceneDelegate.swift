//
//  SceneDelegate.swift
//  MovieApp
//
//  Created by Abilkaiyr Nurzhan on 08.02.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator : AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
    
        let navController = UINavigationController()
        let appCoordinator = AppCoordinator(navCon: navController)
        appCoordinator.start()
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
    }

}
