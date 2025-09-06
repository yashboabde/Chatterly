//
//  SettingsView.swift
//  Chatterly
//
//  Created by yash bobade on 16/10/25.
//

import SwiftUI

struct SettingsView: View {
	@Environment(\.dismiss) var dismiss
	@EnvironmentObject var authManager: AuthManager
	
	var body: some View {
		NavigationView {
			List {
				Section {
					Button("Logout") {
						authManager.logout()
						dismiss()
					}
					.foregroundColor(.red)
				}
			}
			.listStyle(InsetGroupedListStyle())
			.navigationTitle("Settings")
			.navigationBarItems(trailing: Button("Done") {
				dismiss()
			})
		}
	}
}
