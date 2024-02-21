//
//  AppCoordinator.swift
//  ios-GameApp
//
//  Created by Pero Ivic on 21/02/2024.
//

import UIKit

class AppCoordinator {
    
    var navigationController: UINavigationController!
    
    static let shared = AppCoordinator()
    
    func prepare(window: UIWindow?, rootViewController: UIViewController) {
        window?.makeKeyAndVisible()
        window?.rootViewController = rootViewController
        setupNavigation(rootViewController: rootViewController)
        addControllers()
    }
    
    func setupNavigation(rootViewController: UIViewController) {
        navigationController = UINavigationController(rootViewController: rootViewController)
    }
    
    func addControllers() {
        navigationController.setViewControllers([OnboardingViewController(), GamesViewController()], animated: true)
    }
    
}
