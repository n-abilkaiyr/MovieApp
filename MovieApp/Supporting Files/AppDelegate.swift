//
//  AppDelegate.swift
//  MovieApp
//
//  Created by Abilkaiyr Nurzhan on 08.02.2022.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

//    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
//        window?.makeKeyAndVisible()
//        let movieListViewModel = MovieListViewModel()
//        let navController = UINavigationController(rootViewController: MovieListViewController(viewModel: movieListViewModel))
//        window?.rootViewController = navController
        return true
    }

}
