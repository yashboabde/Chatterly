//
//  AuthManager.swift
//  Chatterly
//
//  Created by yash bobade on 16/10/25.
//

import SwiftUI

class AuthManager: ObservableObject {
	@Published var isLoggedIn = false
	
	func login() {
		isLoggedIn = true
	}
	
	func logout() {
		isLoggedIn = false
	}
}
