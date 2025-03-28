//
//  AppDelegate.swift
//  WordGame
//
//  Created by Kseniia on 2025-03-25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
        var globalWordPairs: [WordPair] = []
        
        func applicationDidFinishLaunching(_ application: UIApplication) {
          
            globalWordPairs = [
                WordPair(english: "cat", swedish: "katt"),
                WordPair(english: "dog", swedish: "hund"),
                WordPair(english: "bird", swedish: "fågel"),
                WordPair(english: "worm", swedish: "mask"),
                WordPair(english: "shark", swedish: "haj"),
                WordPair(english: "goat", swedish: "get")
            ]
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }




