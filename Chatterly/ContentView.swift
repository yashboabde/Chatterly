//
//  ContentView.swift
//  Chatterly
//
//  Created by yash bobade on 21/09/25.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
	@StateObject private var authManager = AuthManager()
	
	var body: some View {
		Group {
			if authManager.isLoggedIn {
				ConversationListView()
			} else {
				LoginView()
			}
		}
		.environmentObject(authManager)
	}
}
