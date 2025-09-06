//
//  SignUpView.swift
//  Chatterly
//
//  Created by yash bobade on 16/10/25.
//

import SwiftUI

struct SignUpView: View {
	@Environment(\.dismiss) var dismiss
	@EnvironmentObject var authManager: AuthManager
	@State private var email = ""
	@State private var password = ""
	@State private var confirmPassword = ""
	
	var body: some View {
		NavigationView {
			VStack(spacing: 20) {
				Text("Create Account")
					.font(.largeTitle)
					.fontWeight(.bold)
				
				VStack(spacing: 15) {
					TextField("Email", text: $email)
						.textFieldStyle(RoundedBorderTextFieldStyle())
						.keyboardType(.emailAddress)
						.autocapitalization(.none)
					
					SecureField("Password", text: $password)
						.textFieldStyle(RoundedBorderTextFieldStyle())
					
					SecureField("Confirm Password", text: $confirmPassword)
						.textFieldStyle(RoundedBorderTextFieldStyle())
					
					Button("Sign Up") {
						// Handle sign up logic
						authManager.login()
						dismiss()
					}
					.buttonStyle(PrimaryButtonStyle())
				}
				.padding(.horizontal)
				
				Spacer()
			}
			.padding()
			.navigationBarItems(leading: Button("Cancel") {
				dismiss()
			})
		}
	}
}
