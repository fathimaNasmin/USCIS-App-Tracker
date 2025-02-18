//
//  BoxModifier.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/6/25.
//

import SwiftUI

struct BoxModifier: ViewModifier {
	let opacity: Double
	let radius: CGFloat
	let x: CGFloat
	let y: CGFloat
	
	func body(content: Content) -> some View {
		content
			.padding()
			.background(.white)
			.clipShape(RoundedRectangle(cornerRadius: 20))
			.shadow(color: .gray.opacity(opacity), radius: radius, x: x, y: y)
	}
}



extension View {
	func customBoxModifier(opacity: Double = 0.5, radius: CGFloat, x: CGFloat = 0, y: CGFloat = 0) -> some View {
		modifier(BoxModifier(opacity: opacity, radius: radius, x: x, y: y))
	}
}
