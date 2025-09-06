//
//  PrimaryButtonStyle.swift
//  Chatterly
//
//  Created by yash bobade on 16/10/25.
//


import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.frame(maxWidth: .infinity)
			.padding()
			.background(Color.blue)
			.foregroundColor(.white)
			.cornerRadius(8)
			.scaleEffect(configuration.isPressed ? 0.95 : 1.0)
	}
}
