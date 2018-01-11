//
//  AppDelegate.swift
//  Croma
//
//  Created by Rafael Aguilera on 10/29/17.
//  Copyright © 2017 Rafael Aguilera. All rights reserved.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?)
        -> Bool {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            
            FirebaseApp.configure()
            
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
            let loginStoryboard: UIStoryboard = UIStoryboard(name: "Login",bundle: nil)
            var initialViewController: UIViewController
            
            if Auth.auth().currentUser != nil{
                initialViewController = mainStoryboard.instantiateViewController(withIdentifier: "BeersTableViewController") as! UITabBarController // 'LoginController' is the storyboard id of LoginViewController
            }else{
                initialViewController = loginStoryboard.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController // 'MainController' is the storyboard id of MainViewController
            }
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
            
            IQKeyboardManager.sharedManager().enable = true
            IQKeyboardManager.sharedManager().enableAutoToolbar = false
            IQKeyboardManager.sharedManager().shouldShowToolbarPlaceholder = false
            IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
            
            return true
    }
}
