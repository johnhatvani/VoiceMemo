//
//  AppDelegate.swift
//  VoiceMemo
//
//  Created by John Hatvani on 14/9/21.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    lazy var persistentContainer: RedordingsPersistentContainer = {
        let container = RedordingsPersistentContainer(name: "RecordingsModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                
        setTheme(.dark)
        applyTheme()
        return true
    }
}

