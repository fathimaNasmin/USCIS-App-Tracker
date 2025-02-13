//
//  HeadingView.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/6/25.
//

import SwiftUI

struct HeadingView: View {
	let headingText: String
	let fontSize: CGFloat?
	
	init(headingText: String, fontSize: CGFloat? = 40) {
		self.headingText = headingText
		self.fontSize = fontSize
	}
    var body: some View {
		HStack {
			Text(headingText)
				.titleStyle(fontSize ?? 40)
				.foregroundColor(.black)
			Spacer()
		}
    }
}

#Preview {
	HeadingView(headingText: "Heading Goes here", fontSize: 40)
}
