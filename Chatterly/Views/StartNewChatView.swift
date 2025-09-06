//
//  StartNewChatView.swift
//  Chatterly
//
//  Created by yash bobade on 16/10/25.
//

import SwiftUI

struct StartNewChatView: View {
	@Environment(\.dismiss) var dismiss
	@State private var email = ""
	
	var body: some View {
		NavigationView {
			VStack(spacing: 20) {
				Text("Start New Chat")
					.font(.title2)
					.fontWeight(.semibold)
				
				VStack(alignment: .leading, spacing: 8) {
					Text("Enter email address")
						.font(.caption)
						.foregroundColor(.secondary)
					
					TextField("email@example.com", text: $email)
						.textFieldStyle(RoundedBorderTextFieldStyle())
						.keyboardType(.emailAddress)
						.autocapitalization(.none)
				}
				.padding(.horizontal)
				
				Spacer()
				
				Button("Start Chat") {
					// Handle starting new chat logic
					dismiss()
				}
				.buttonStyle(PrimaryButtonStyle())
				.disabled(email.isEmpty)
			}
			.padding()
			.navigationBarItems(leading: Button("Cancel") {
				dismiss()
			})
		}
	}
}
