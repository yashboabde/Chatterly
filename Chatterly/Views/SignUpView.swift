import SwiftUI
import FirebaseAuth

struct SignUpView: View {
	@ObservedObject var authManager: AuthManager
	@Environment(\.presentationMode) var presentationMode
	@State private var username = ""
	@State private var email = ""
	@State private var password = ""
	@State private var confirmPassword = ""
	@State private var errorMessage: String?

	var body: some View {
		NavigationView {
			VStack(spacing: 20) {
				
				Spacer()
				
				Text("Create Account")
					.font(.largeTitle)
					.bold()

				TextField("Username", text: $username)
					.padding()
					.background(Color(.secondarySystemBackground))
					.cornerRadius(8)

				TextField("Email", text: $email)
					.keyboardType(.emailAddress)
					.autocapitalization(.none)
					.padding()
					.background(Color(.secondarySystemBackground))
					.cornerRadius(8)

				SecureField("Password", text: $password)
					.padding()
					.background(Color(.secondarySystemBackground))
					.cornerRadius(8)

				SecureField("Confirm Password", text: $confirmPassword)
					.padding()
					.background(Color(.secondarySystemBackground))
					.cornerRadius(8)

				if let errorMessage = errorMessage {
					Text(errorMessage)
						.foregroundColor(.red)
						.multilineTextAlignment(.center)
						.padding(.horizontal)
				}

				Button(action: signUp) {
					Text("Sign Up")
						.foregroundColor(.white)
						.frame(maxWidth: .infinity)
						.padding()
						.background(Color.blue)
						.cornerRadius(8)
				}

				Spacer()
			}
			.padding()
		}
	}

	private func signUp() {
		// Check if passwords match
		guard password == confirmPassword else {
			self.errorMessage = "Passwords do not match."
			return
		}
		
		// Optional: Add a minimum password length check
		guard password.count >= 6 else {
			self.errorMessage = "Password must be at least 6 characters."
			return
		}

		authManager.signUp(username: username, email: email, password: password) { result in
			switch result {
			case .success:
				presentationMode.wrappedValue.dismiss()
			case .failure(let error):
				self.errorMessage = error.localizedDescription
			}
		}
	}
}

