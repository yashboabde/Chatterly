//
//  SwiftUIView.swift
//  Chatterly
//
//  Created by yash bobade on 16/10/25.
//

import SwiftUI

struct LoginView: View {
	@EnvironmentObject var authManager: AuthManager
	@State private var email = ""
	@State private var password = ""
	@State private var showingSignUp = false
	
	var body: some View {
		NavigationView {
			VStack(spacing: 20) {
				Text("Welcome Back")
					.font(.largeTitle)
					.fontWeight(.bold)
				
				VStack(spacing: 15) {
					TextField("Email", text: $email)
						.textFieldStyle(RoundedBorderTextFieldStyle())
						.keyboardType(.emailAddress)
						.autocapitalization(.none)
					
					SecureField("Password", text: $password)
						.textFieldStyle(RoundedBorderTextFieldStyle())
					
					Button("Login") {
						// Handle login logic
						authManager.login()
					}
					.buttonStyle(PrimaryButtonStyle())
				}
				.padding(.horizontal)
				
				Button("Don't have an account? Sign Up") {
					showingSignUp = true
				}
				
				Spacer()
			}
			.padding()
			.navigationBarHidden(true)
			.sheet(isPresented: $showingSignUp) {
				SignUpView()
			}
		}
	}
}
