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
    fileprivate let navigationRouter: NavigationRouter
    let configurators: [ApplicationConfiguratorProtocol]
    var window: UIWindow?
    
    // MARK: - Initializer
    
    override init() {
        let dataService = DataService()
        self.dataService = dataService
        self.navigationRouter = NavigationRouter(dataService: dataService)
        configurators = []
        super.init()
    }
    
    // MARK: - Helper functions
    
    fileprivate func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = navigationRouter.navigationController
    }
    
    fileprivate func configure(_ application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        configurators.forEach { $0.configure(application, launchOptions: launchOptions) }
    }
}

// MARK: -

extension AppDelegate: UIApplicationDelegate {
    
    // MARK: - UIApplicationDelegate methods
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configure(application, launchOptions: launchOptions)
        setupWindow()
        return true
    }
}
