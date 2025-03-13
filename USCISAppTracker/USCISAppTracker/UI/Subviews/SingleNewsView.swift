//
//  SingleNewsView.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/5/25.
//

import SwiftUI

struct SingleNewsView: View {
	@Binding var selectedNewsId: Int?
	var singleNews: News
	
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
			HStack {
				Text(singleNews.title)
					.subTitleStyle(16)
					.fontWeight(.medium)
					.padding(.bottom, 5)
					.foregroundColor(.black)
				Spacer()
			}
		}
		.customBoxModifier(opacity:0.2, radius:3, x: 0, y: 2)
	}
}

//#Preview {
//    SingleNewsView()
//}
