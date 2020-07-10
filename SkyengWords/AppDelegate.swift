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
    
    private var coreWindow: UIWindow?
    
    // MARK: - Lifecycle
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let networkService = NetworkService()
        let wordsService = WordsService(networkService: networkService)
        wordsService.obtainWords(with: "test", page: 1, pageSize: 10)
        
        return true
    }
    
}

