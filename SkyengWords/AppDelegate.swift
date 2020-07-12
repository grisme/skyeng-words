//
//  AppDelegate.swift
//  SkyengWords
//
//  Created by Eugene Garifullin on 10.07.2020.
//  Copyright © 2020 Grisme Team. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Properties
    
    /// Application's core window
    private var coreWindow: UIWindow?
    
    // MARK: - Lifecycle
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Starting up first module
        setupCoreWindow(rootViewController: buildFirstModule())
        
        return true
    }
    
    // MARK: - Private methods
    
    /// Setting up and showing application's core window
    /// - Parameter rootViewController: Window's root view controller
    private func setupCoreWindow(rootViewController: UIViewController) {
        coreWindow = UIWindow(frame: UIScreen.main.bounds)
        coreWindow?.rootViewController = rootViewController
        coreWindow?.makeKeyAndVisible()
    }
    
    /// Builds and prepares first module to be shown
    /// - Returns: Prepared first module view controller
    private func buildFirstModule() -> UIViewController {
        let searchViewController = SearchAssembly.assembleSearch()
        let navigationController = UINavigationController(rootViewController: searchViewController)
        return navigationController
    }
    
}

