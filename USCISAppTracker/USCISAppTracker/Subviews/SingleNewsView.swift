//
//  SingleNewsView.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/5/25.
//

import SwiftUI

struct SingleNewsView: View {
	var body: some View {
		VStack{
			HStack {
				Text("News Source")
					.titleStyle(15)
					.foregroundColor(Color.bluePrimary)
				
				Spacer()
				
				Text("16th June 2024")
					.captionStyle(12)
					.foregroundColor(Color.textGray)
			}
			
			Rectangle()
				.frame(height: 1)
				.frame(maxWidth: .infinity)
				.foregroundColor(Color.textGray)
			
			Text("Lorem ipsum dolor sit amet, con in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
				.subTitleStyle(18)
				.fontWeight(.medium)
				.padding(.bottom, 10)
				.foregroundColor(.black)
			
			Text("Read More")
				.titleStyle(18)
				.frame(height: 35)
				.frame(maxWidth: .infinity)
				.foregroundColor(.white)
				.background(Color.blueMainColor)
				.clipShape(RoundedRectangle(cornerRadius: 20))
		}
		.padding()
		.background(.white)
		.clipShape(RoundedRectangle(cornerRadius: 20))
		.shadow(color: .gray.opacity(0.2), radius: 3, x: 0, y: 2)
	}
}

#Preview {
    SingleNewsView()
}
