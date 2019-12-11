//
//  AppDelegate.swift
//  GoldTracker
//
//  Created by Nattapon on 5/3/2561 BE.
//  Copyright © 2561 Nattapon. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    internal func application(_ application: UIApplication,
                              didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // init IQKeybroadManager
        IQKeyboardManager.shared.enable = true
        
        // reload root view controller
        reloadRootViewController()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate {
    
    // MARK: ### init View Controller ###
    
    func reloadRootViewController() {
        
        if let rootViewController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
            rootViewController.popToRootViewController(animated: false)
        }
        
        
       setupHomeAsRootViewController()
    }
    
    
    // MARK: ### init View controller ###
    
    private func setRootViewController(viewcontroller vc : UIViewController) {
        
        // transition with effect if have old view controller before
        if let targetView = self.window?.rootViewController {
            
            // prevent from transition to same viewcontroller
            let debug = isSameClass(obj1: targetView , obj2: vc)
            print("DEBUG isSameClass : \(debug)")
            guard !isSameClass(obj1: targetView , obj2: vc) else {
                print(targetView.description)
                return
            }
            
            self.window?.rootViewController     = vc// set as root view controller
            self.window?.makeKeyAndVisible()
            
            
        } else {
            // first time set root view contrller
            
            self.window                         = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController     = vc// set as root view controller
            self.window?.makeKeyAndVisible()
        }
        
    }
    
    // compare is the same class
    func isSameClass(obj1 : AnyObject ,obj2 : AnyObject) -> Bool {
        return (object_getClassName(obj1) == object_getClassName(obj2))
    }
    
    private func setupHomeAsRootViewController() {
        
        let homeVC = HomeWireFrame.createModule()
        
        // setup root view
       
        setRootViewController(viewcontroller : homeVC)
        
        print("set home page as root")
        
    }
    
}

