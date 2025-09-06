//
//  ConversationListView.swift
//  Chatterly
//
//  Created by yash bobade on 16/10/25.
//

import SwiftUI

struct ConversationListView: View {
	@State private var conversations: [Conversation] = [
		Conversation(id: "1", name: "John Doe", lastMessage: "Hey, how are you?", timestamp: "10:30 AM"),
		Conversation(id: "2", name: "Jane Smith", lastMessage: "Meeting at 3 PM", timestamp: "Yesterday"),
		Conversation(id: "3", name: "Team Chat", lastMessage: "Alex: I'll send the files", timestamp: "Oct 12")
	]
	@State private var showingNewChat = false
	@State private var showingSettings = false
	
	var body: some View {
		NavigationView {
			List(conversations) { conversation in
				NavigationLink(destination: ChatView(conversation: conversation)) {
					ConversationRow(conversation: conversation)
				}
			}
			.listStyle(PlainListStyle())
			.navigationTitle("Chats")
			.navigationBarItems(
				leading: Button(action: {
					showingSettings = true
				}) {
					Image(systemName: "gear")
				},
				trailing: Button(action: {
					showingNewChat = true
				}) {
					Image(systemName: "square.and.pencil")
				}
			)
			.sheet(isPresented: $showingNewChat) {
				StartNewChatView()
			}
			.sheet(isPresented: $showingSettings) {
				SettingsView()
			}
		}
	}
}
