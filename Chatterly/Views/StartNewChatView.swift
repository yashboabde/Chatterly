//
//  StartNewChatView.swift
//  Chatterly
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct StartNewChatView: View {
	@Environment(\.dismiss) var dismiss
	@State private var email = ""
	@State private var isLoading = false
	@State private var errorMessage: String?

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

				if let errorMessage = errorMessage {
					Text(errorMessage)
						.foregroundColor(.red)
						.font(.caption)
						.padding(.horizontal)
				}

				Spacer()

				Button(action: startChat) {
					if isLoading {
						ProgressView()
							.progressViewStyle(CircularProgressViewStyle(tint: .white))
							.frame(maxWidth: .infinity)
							.padding()
					} else {
						Text("Start Chat")
							.frame(maxWidth: .infinity)
							.padding()
					}
				}
				.buttonStyle(PrimaryButtonStyle())
				.disabled(email.isEmpty || isLoading)
			}
			.padding()
			.navigationBarItems(leading: Button("Cancel") {
				dismiss()
			})
		}
	}

	// MARK: - Core Logic
	private func startChat() {
		guard email.contains("@") else {
			errorMessage = "Please enter a valid email address."
			return
		}

		guard let currentEmail = Auth.auth().currentUser?.email else {
			errorMessage = "You must be logged in."
			return
		}

		if email == currentEmail {
			errorMessage = "You cannot chat with yourself."
			return
		}

		errorMessage = nil
		isLoading = true

		let db = Firestore.firestore()

		// STEP 1 — Check if this user exists
		db.collection("users")
			.whereField("email", isEqualTo: email)
			.getDocuments { snapshot, error in
				
				if let error = error {
					self.errorMessage = "Failed: \(error.localizedDescription)"
					self.isLoading = false
					return
				}

				guard let document = snapshot?.documents.first else {
					self.errorMessage = "No user found with that email."
					self.isLoading = false
					return
				}

				// Extract their info
				let data = document.data()
				let otherName = data["name"] as? String ?? email

				// STEP 2 — Save BOTH SIDES of the relationship
				self.saveForBothUsers(currentEmail: currentEmail,
									  otherEmail: email,
									  otherName: otherName)
			}
	}

	// MARK: - Save in BOTH user contact lists
	private func saveForBothUsers(currentEmail: String, otherEmail: String, otherName: String) {
		let db = Firestore.firestore()

		let batch = db.batch()

		// Current user → Other user
		let ref1 = db.collection("users")
			.document(currentEmail)
			.collection("contacts")
			.document(otherEmail)

		batch.setData([
			"email": otherEmail,
			"name": otherName
		], forDocument: ref1)

		// Other user → Current user
		let ref2 = db.collection("users")
			.document(otherEmail)
			.collection("contacts")
			.document(currentEmail)

		batch.setData([
			"email": currentEmail,
			"name": currentEmail   // You can replace with current user's name someday
		], forDocument: ref2)

		// Commit write
		batch.commit { error in
			self.isLoading = false
			if let error = error {
				self.errorMessage = "Failed to save contacts: \(error.localizedDescription)"
				return
			}

			print("Contacts saved for BOTH users!")
			dismiss()
		}
	}
}

