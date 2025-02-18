//
//  TextFieldModifier.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/6/25.
//

import Foundation
import SwiftUI

struct RoundedRectangleTextFieldStyle: TextFieldStyle {
	private let rectangleCornerRadius: CGFloat = 15
	
	func _body(configuration: TextField<Self._Label>) -> some View {
		configuration
			.padding(15)
			.background(.white)
			.clipShape(.rect(cornerRadius: rectangleCornerRadius))
			.overlay {
				RoundedRectangle(cornerRadius: rectangleCornerRadius)
					.stroke(Color.textGray.opacity(0.5), lineWidth: 2)
			}
	}
}

