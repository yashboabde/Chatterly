//
//  ChatterlyApp.swift
//  Chatterly
//
//  Created by assistant on 18/10/25.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
		let db = Firestore.firestore()
		
        return true
    }
}

@main
struct ChatterlyApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
  @StateObject var authManager = AuthManager()

  var body: some Scene {
    WindowGroup {
      NavigationView {
        ContentView()
          .environmentObject(authManager)
      }
    }
  }
}
