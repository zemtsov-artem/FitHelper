//
//  AppDelegate.swift
//  FitHelper
//
//  Created by артем on 27.04.17.
//  Copyright © 2017 артем. All rights reserved.
//

import UIKit
import CoreData
import RAMAnimatedTabBarController



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if (Exercise.allExercises().count == 0) {
            setDefaultsExercises()
        }
        if Training.allTrainings().count == 0 {
            setDefaultTrainings()
        }
        UINavigationBar.appearance().barTintColor = UIColor.white

    
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.red]
        
        return true
    }
    
}
extension UIViewController{
    var previousViewController:UIViewController?{
        if let controllersOnNavStack = self.navigationController?.viewControllers{
            let n = controllersOnNavStack.count
            //if self is still on Navigation stack
            if controllersOnNavStack.last === self, n > 1{
                return controllersOnNavStack[n - 2]
            }else if n > 0{
                return controllersOnNavStack[n - 1]
            }
        }
        return nil
    }
}
