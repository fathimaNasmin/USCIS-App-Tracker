//
//  InfoView.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/6/25.
//

import SwiftUI

struct InfoView: View {
	@Binding var isInfoButtonTapped: Bool
	
	var body: some View {
		HStack {
			VStack(alignment: .leading) {
				Text("The Receipt Number is a 13-character code USCIS gives to track your case.")
					.padding(.bottom, 10)
					.foregroundColor(.black)
				
				Text("It starts with three letters (e.g., EAC, WAC, LIN) followed by 10 numbers. You can find it on USCIS notices.")
					.padding(.bottom, 10)
					.foregroundColor(.black)
				
				Text("Do not enter dashes (-), but include other symbols like (*) if shown on your notice.")
					.padding(.bottom, 10)
					.foregroundColor(.black)
				
				Text("GOT IT")
					.foregroundColor(.blue)
					.subTitleStyle(15)
					.fontWeight(.bold)
					.onTapGesture {
						withAnimation(.snappy(duration: 0.3)){
							isInfoButtonTapped = false
						}
					}
				
			}
			.subTitleStyle(15)
			.frame(height: 190)
			.frame(maxWidth: .infinity, alignment: .leading)
			.padding(15)
			.padding(.vertical, 8)
			.background(.white)
			.clipShape(RoundedRectangle(cornerRadius: 15))
			.shadow(color: .gray.opacity(0.5), radius: 15, x: 5, y: 5)
			.padding(.top, 50)
			.padding(.horizontal, 20)
		}
		
	}
}


