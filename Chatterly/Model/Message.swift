//
//  Message.swift
//  Chatterly
//
//  Created by yash bobade on 16/10/25.
//
import Foundation
import FirebaseFirestore

struct Message: Identifiable, Codable {
	@DocumentID var id: String?
	let text: String
	let senderId: String
	let timestamp: Date
}
