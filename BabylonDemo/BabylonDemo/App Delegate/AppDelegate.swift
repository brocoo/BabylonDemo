//
//  AppDelegate.swift
//  BabylonDemo
//
//  Created by Julien Ducret on 3/1/19.
//  Copyright © 2019 Julien Ducret. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder {
    
    // MARK: - Properties
    
    fileprivate let dataService: DataService
    var window: UIWindow?
    
    // MARK: - Initializer
    
    override init() {
        self.dataService = DataService(apiService: APIService())
        super.init()
    }
    
    // MARK: - Helper functions
    
    fileprivate func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = NavigationCoordinator(dataService: dataService).navigationController
    }
}

// MARK: -

extension AppDelegate: UIApplicationDelegate {
    
    // MARK: - UIApplicationDelegate methods
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupWindow()
        return true
    }
}
