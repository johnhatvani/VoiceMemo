//
//  AppDelegate.swift
//  VoiceMemo
//
//  Created by John Hatvani on 14/9/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setTheme(.dark)
        applyTheme()
        return true
    }
}

