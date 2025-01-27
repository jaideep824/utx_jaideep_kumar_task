//
//  AppDelegate.swift
//  JaideepTaskCrypto
//
//  Created by Jaideep on 26/01/25.
//

import UIKit

// TODO: Add Dark Mode switch instruction, pull down refresh, sheet, codable with core data in readme file
// TODO: Unit tests
// TODO: Git and Git Push

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        setAppMode()
        setRootController()
        
        return true
    }
}

private extension AppDelegate {
    func setRootController() {
        let viewModel = CryptoListViewModel(storageService: CoreDataStorage.shared)
        let controller = CryptoListViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: controller)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func setAppMode() {
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .dark
        }
    }
}
