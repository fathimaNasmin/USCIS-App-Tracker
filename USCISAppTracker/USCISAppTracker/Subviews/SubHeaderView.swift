//
//  SubHeaderView.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/12/25.
//

import SwiftUI

struct SubHeaderView: View {
	@Environment(\.dismiss) var goBack
	
	let title: String
	let iconName: String?
//	let goBack: (() -> Void)?
	let iconAction: (() -> Void)?
	
    var body: some View {
		HStack {
			Button(action: { goBack() }) {
				Image(systemName: "arrow.left")
					.titleStyle(20)
					.fontWeight(.bold)
			}
			
			Spacer()
			
			// Title of the page
			Text(title)
				.titleStyle(20)
			
			Spacer()
			
			// Icon for some action
			if let iconName = iconName, let iconAction = iconAction {
				Button {
					print("Edit action")
					iconAction()
				} label: {
					Image(systemName: iconName)
						.titleStyle(20)
						.fontWeight(.bold)
				}
			}
			
		}
		.padding()
		.padding(.vertical, 5)
		.background(Color.blueMainColor)
		.foregroundColor(.white)

    }
}

#Preview {
	SubHeaderView(title: "Notification", iconName: nil, iconAction: nil)
}
