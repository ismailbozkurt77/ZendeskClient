//
//  AppDelegate.swift
//  ZendeskExercise
//
//  Created by Ismail on 08/01/2017.
//  Copyright © 2017 Zendesk. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    // MARK: - <UIApplicationDelegate>
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        self.setupRootViewController()
        
        return true
    }
    
    // MARK: - Private
    
    func setupRootViewController() {
        let ticketListViewController = TicketListModuleBuilder().buildTicketlistModule()
        let navigationController = UINavigationController(rootViewController: ticketListViewController)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
}
