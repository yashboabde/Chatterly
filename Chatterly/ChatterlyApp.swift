//
//  ChatterlyApp.swift
//  Chatterly
//
//  Created by yash bobade on 06/09/25.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

// MARK: - AppDelegate
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
				   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
	// Configure Firebase here
	FirebaseApp.configure()
	  
	let db = Firestore.firestore()
	  
	return true

	
  }
}

@main
struct ChatterlyApp: App {
  // Register AppDelegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

  var body: some Scene {
	WindowGroup {
	  NavigationView {
		ContentView()
	  }
	}
  }
}

