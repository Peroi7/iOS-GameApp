//
//  AppCoordinator.swift
//  ios-GameApp
//
//  Created by Pero Ivic on 21/02/2024.
//

import UIKit

class AppCoordinator {
    
    static let shared = AppCoordinator()
    private var parentViewController: UIViewController!
    private var preSavedGenres: [Int] = LocalData.shared.loadSavedGenres()
    
    private enum Constants {
        static let gamesOverviewTitle = "Games Overview"
        static let genresOverviewTitle = "Genres"
    }
    
    private var isOnboardingPresented: Bool = UserDefaults.standard.value(forKey: AppConstants.keyIsOnboardingPresented) as? Bool ?? false {
        didSet {
            UserDefaults.standard.setValue(isOnboardingPresented, forKey: AppConstants.keyIsOnboardingPresented)
        }
    }
    
    //MARK: - Start
    
    func start(window: UIWindow?) {
        let gamesViewController = GamesViewController()
        let rootViewController = CustomNavigationController(rootViewController: gamesViewController)
        
        if !isOnboardingPresented {
            addChild(parent: gamesViewController, isEdit: false)
        } else {
            gamesViewController.navigationItem.title = Constants.gamesOverviewTitle
            gamesViewController.shouldFetchData = true
            gamesViewController.addRightBarButton()
        }
        
        window?.makeKeyAndVisible()
        window?.rootViewController = rootViewController
        parentViewController = gamesViewController
    }
    
    //MARK: - Child
    
    func addChild(parent: UIViewController, isEdit: Bool) {
        let child = OnboardingViewController(isEdit: isEdit)
        parent.addChild(child)
        child.view.frame = parent.view.frame
        parent.view.addSubview(child.view)
        child.didMove(toParent: parent)
        parent.navigationItem.title = Constants.genresOverviewTitle
    }
    
    //MARK: - Onboarding
    
    func removeOnboarding(child: UIViewController) {
        guard let child = child as? OnboardingViewController else { return }
        child.removeFromParent()
        child.view.removeFromSuperview()
        if let parentViewController = parentViewController as? GamesViewController {
            parentViewController.navigationItem.title = Constants.gamesOverviewTitle
            parentViewController.addRightBarButton()
            parentViewController.shouldFetchData = true
            isOnboardingPresented = true
        }
    }
    
    //MARK: - Settings
    
    func openSettings(parent: UIViewController) {
        let settingsViewController = OnboardingViewController(isEdit: true)
        settingsViewController.modalPresentationStyle = .fullScreen
        parent.present(settingsViewController, animated: true)
    }
    
    func dismissSettings(viewController: UIViewController) {
        viewController.dismiss(animated: true)
        if let parentViewController = parentViewController as? GamesViewController {
            if LocalData.shared.loadSavedGenres() != preSavedGenres {
                parentViewController.shouldFetchData = true
                preSavedGenres = LocalData.shared.loadSavedGenres()
            }
        }
    }
}
