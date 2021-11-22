//
//  AppDelegate.swift
//  BrewApps
//
//  Created by Abishek on 22/11/21.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window:UIWindow?
  var navigationController: UINavigationController!

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    self.setRootController(controller: BrewAppsHomeViewController())
    return true
  }

}

extension AppDelegate{
  
  func setRootController(controller: UIViewController){
    
    self.window = UIWindow(frame: UIScreen.main.bounds)
    self.navigationController = UINavigationController(rootViewController: controller)
    self.navigationController?.navigationBar.isHidden = true
    self.navigationController?.modalTransitionStyle = .coverVertical
    self.window?.rootViewController = self.navigationController
    self.window?.makeKeyAndVisible()
    
  }
  
}
