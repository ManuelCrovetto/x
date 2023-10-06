//
//  XApp.swift
//  X
//
//  Created by Manuel Crovetto on 16/09/2023.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct XApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var xTabViewViewModel = XTabViewModel()
    var body: some Scene {
        WindowGroup {
           ContentView()
        }
    }
}
