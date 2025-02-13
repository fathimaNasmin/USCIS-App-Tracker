//
//  CustomViewModifier.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/5/25.
//

import Foundation
import SwiftUI

struct TitleFontModifier: ViewModifier {
	let size: CGFloat
	
	func body(content: Content) -> some View {
		content
			.font(.robotoMedium(size))
			.fontWeight(.bold)
	}
}

struct ParagraphFontModifier: ViewModifier {
	let size: CGFloat
	
	func body(content: Content) -> some View {
		content
			.font(.robotoExtraLight(size))
	}
}

struct SubTitleFontModifier: ViewModifier {
	let size: CGFloat
	
	func body(content: Content) -> some View {
		content
			.font(.robotoRegular(size))
	}
}

struct CaptionFontModifier: ViewModifier {
	let size: CGFloat
	
	func body(content: Content) -> some View {
		content
			.font(.robotoLight(size))
	}
}


extension View {
	func titleStyle(_ size:CGFloat) -> some View {
		modifier(TitleFontModifier(size: size))
	}
	
	func paragraphStyle(_ size:CGFloat) -> some View {
		modifier(ParagraphFontModifier(size: size))
	}
	
	func subTitleStyle(_ size:CGFloat) -> some View {
		modifier(SubTitleFontModifier(size: size))
	}
	
	func captionStyle(_ size:CGFloat) -> some View {
		modifier(CaptionFontModifier(size: size))
	}
}
