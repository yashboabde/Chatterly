import SwiftUI

struct LoginView: View {
	@StateObject private var authManager = AuthManager()
	@State private var email = ""
	@State private var password = ""
	@State private var errorMessage: String?
	@State private var isShowingSignUp = false

	var body: some View {
		NavigationView {
			VStack(spacing: 20) {
				
				Spacer()
				
				Text("Welcome Back")
					.font(.largeTitle)
					.bold()

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

				if let errorMessage = errorMessage {
					Text(errorMessage)
						.foregroundColor(.red)
						.multilineTextAlignment(.center)
						.padding(.horizontal)
				}

				Button(action: login) {
					Text("Login")
						.foregroundColor(.white)
						.frame(maxWidth: .infinity)
						.padding()
						.background(Color.blue)
						.cornerRadius(8)
				}

				Button(action: {
					isShowingSignUp = true
				}) {
					Text("Don't have an account? Sign Up")
						.foregroundColor(.blue)
				}

				Spacer()
			}
			.padding()
			.fullScreenCover(isPresented: $authManager.isLoggedIn) {
				// Destination after login
				ConversationListView()
			}
			.sheet(isPresented: $isShowingSignUp) {
				SignUpView(authManager: authManager)
			}
		}
	}

	private func login() {
		authManager.login(email: email, password: password) { result in
			switch result {
			case .success:
				break
			case .failure(let error):
				self.errorMessage = error.localizedDescription
			}
		}
	}
}

#Preview {
	LoginView()
}
