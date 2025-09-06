//
//  Message.swift
//  Chatterly
//
//  Created by yash bobade on 16/10/25.
//

import Foundation
import SwiftUI


struct Message: Identifiable {
	let id: String
	let text: String
	let isFromCurrentUser: Bool
	let timestamp: Date
}
