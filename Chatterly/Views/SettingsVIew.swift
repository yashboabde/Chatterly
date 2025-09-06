//
//  ProfileView.swift
//  Chatterly
//
//  Created by yash bobade on 02/11/25.
//

import SwiftUI
import FirebaseAuth

struct SettingsView: View {
	@EnvironmentObject var authManager: AuthManager
	@Environment(\.dismiss) private var dismiss

	var body: some View {
		VStack {
			Spacer()
			
			Text(authManager.userEmail ?? "No user logged in")
			
			
			Spacer()
			
			
			Button("Logout") {
				logout()
				dismiss()
			}
			
			Spacer()
		}
		.padding()
		.navigationTitle("Profile")
	}

	// MARK: - Logout
	private func logout() {
		authManager.logout()
		dismiss() // closes ProfileView (sheet or push)
	}
}

