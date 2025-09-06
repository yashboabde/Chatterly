//
//  ChatUser.swift
//  Chatterly
//
//  Created by yash bobade on 20/11/25.
//

import Foundation
import FirebaseFirestore

struct ChatUser: Identifiable, Codable {
	@DocumentID var id: String?
	var name: String
	var email: String
}
