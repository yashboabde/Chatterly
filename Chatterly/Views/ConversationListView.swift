import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct ConversationListView: View {

	@State private var showingSettings = false
	@State private var showingNewChat = false
	@State private var users: [ChatUser] = []

	var body: some View {
		NavigationStack {
			List(users) { user in
				NavigationLink(destination: ChatView(conversationId: createConversationId(with: user))) {
					HStack {
						Circle()
							.fill(Color.blue.opacity(0.2))
							.frame(width: 44, height: 44)
							.overlay(Text(String(user.name.prefix(1))))

						VStack(alignment: .leading) {
							Text(user.name)
								.font(.headline)
							Text(user.email)
								.font(.subheadline)
								.foregroundColor(.gray)
						}
					}
				}
			}
			.listStyle(.plain)
			.navigationTitle("Chats")

			// Modern toolbar API
			.toolbar {
				ToolbarItem(placement: .navigationBarLeading) {
					Button {
						showingSettings = true
					} label: {
						Image(systemName: "person.crop.circle")
					}
				}

				ToolbarItem(placement: .navigationBarTrailing) {
					Button {
						showingNewChat = true
					} label: {
						Image(systemName: "square.and.pencil")
					}
				}
			}

			.sheet(isPresented: $showingNewChat) {
				StartNewChatView()
			}
			.sheet(isPresented: $showingSettings) {
				SettingsView()
			}

			.refreshable {
				fetchUsers()
			}

			.onAppear {
				fetchUsers()
			}
		}
	}

	func createConversationId(with user: ChatUser) -> String {
		let currentEmail = Auth.auth().currentUser?.email ?? ""
		let otherEmail = user.email
		return [currentEmail, otherEmail].sorted().joined(separator: "_")
	}

	func fetchUsers() {
		guard let currentEmail = Auth.auth().currentUser?.email else { return }

		Firestore.firestore()
			.collection("users")
			.document(currentEmail)
			.collection("contacts")
			.getDocuments { snapshot, error in
				
				if let error = error {
					print("❌ Error fetching contacts: \(error)")
					return
				}

				self.users = snapshot?.documents.compactMap { doc in
					try? doc.data(as: ChatUser.self)
				} ?? []
			}
	}

}

#Preview {
	ConversationListView()
}

