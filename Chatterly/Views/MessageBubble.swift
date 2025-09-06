import SwiftUI
import FirebaseAuth

struct MessageBubble: View {
	let message: Message

	// Check if the message was sent by the current user
	var isMe: Bool {
		message.senderId == Auth.auth().currentUser?.email
	}

	var body: some View {
		HStack {
			if isMe {
				Spacer()    // my message → push bubble to the right
			}

			Text(message.text)
				.padding(12)
				.background(isMe ? Color.blue : Color.gray.opacity(0.25))
				.foregroundColor(isMe ? .white : .black)
				.cornerRadius(16)
				.frame(maxWidth: 260, alignment: isMe ? .trailing : .leading)

			if !isMe {
				Spacer()    // other message → push bubble to the left
			}
		}
		.padding(.horizontal)
		.padding(.vertical, 4)
	}
}

