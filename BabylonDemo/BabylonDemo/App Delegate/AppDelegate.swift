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
    fileprivate let navigationRouter: NavigationCoordinator
    var window: UIWindow?
    
    // MARK: - Initializer
    
    override init() {
        let dataService = DataService()
        self.dataService = dataService
        self.navigationRouter = NavigationCoordinator(dataService: dataService)
        super.init()
    }
    
    // MARK: - Helper functions
    
    fileprivate func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = navigationRouter.navigationController
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
