import SwiftUI
import Firebase
import FirebaseAuth



struct ChatView: View {
	let conversationId: String
	@State private var messages: [Message] = []
	@State private var messageText = ""
	let myEmail = Auth.auth().currentUser?.email

	
	private let db = Firestore.firestore()
	
	var body: some View {
		VStack {
			ScrollViewReader { scrollView in
				ScrollView {
					LazyVStack {
						ForEach(messages) { msg in
							HStack {
								if msg.senderId == myEmail {
									Spacer()
									Text(msg.text)
										.padding()
										.background(Color.blue)
										.foregroundColor(.white)
										.cornerRadius(12)
								} else {
									Text(msg.text)
										.padding()
										.background(Color.gray.opacity(0.2))
										.cornerRadius(12)
									Spacer()
								}
							}

							.padding(.horizontal)
							.id(msg.id)
						}
					}
				}
				.onChange(of: messages.count) { _ in
					if let last = messages.last {
						withAnimation {
							scrollView.scrollTo(last.id, anchor: .bottom)
						}
					}
				}
			}
			
			HStack {
				TextField("Message...", text: $messageText)
					.textFieldStyle(RoundedBorderTextFieldStyle())
				
				Button("Send") {
					sendMessage()
				}
				.disabled(messageText.trimmingCharacters(in: .whitespaces).isEmpty)
			}
			.padding()
		}
		.onAppear {
			listenForMessages()
		}
	}
	
	private func sendMessage() {
		let myEmail = Auth.auth().currentUser?.email ?? "unknown"

		let msg = Message(
			id: nil,
			text: messageText,
			senderId: myEmail,
			timestamp: Date()
		)

		do {
			let ref = db.collection("conversations")
				.document(conversationId)
				.collection("messages")
			_ = try ref.addDocument(from: msg)
			
			// Update lastMessage in conversation
			db.collection("conversations").document(conversationId).updateData([
				"lastMessage": messageText
			])
			
			messageText = ""
		} catch {
			print("Error sending message: \(error)")
		}
	}
	
	private func listenForMessages() {
		db.collection("conversations")
			.document(conversationId)
			.collection("messages")
			.order(by: "timestamp")
			.addSnapshotListener { snapshot, error in
				guard let documents = snapshot?.documents else { return }
				messages = documents.compactMap { doc in
					try? doc.data(as: Message.self)
				}
			}
	}
}

