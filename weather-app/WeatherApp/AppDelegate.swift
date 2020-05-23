//
//  AppDelegate.swift
//  weather-app
//
//  Created by Fabrizio Sposetti on 17/05/2020.
//  Copyright © 2020 Fabrizio Sposetti. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                
        let currentCityView = CurrentCityModuleBuilder.createModule()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = currentCityView
        window?.makeKeyAndVisible()
        
        return true
    }


}

