//
//  NotificationDetailView.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/11/25.
//

import SwiftUI

struct NotificationDetailView: View {
	@Environment(\.dismiss) var goBack
	
	var body: some View {
		VStack {
			
			// MARK: Header
			HStack {
				Button(action: {
					goBack()
				}) {
					Image(systemName: "arrow.left")
						.titleStyle(20)
						.fontWeight(.bold)
				}
				
				Spacer()
				
				// MARK: News
				Text("Notification")
					.titleStyle(20)
				
				Spacer()

			}
			.padding()
			.padding(.vertical, 5)
			.background(Color.blueMainColor)
			.foregroundColor(.white)
			
			//MARK: Contents
			
			ScrollView {
				VStack {
					ForEach(1...5, id:\.self) { _ in
						VStack(alignment: .leading){
							Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
								.subTitleStyle(18)
							
							HStack{
								Spacer()
								
								Text("2 hours ago")
								
							}
							.captionStyle(14)
							.foregroundColor(Color.textGray)
							.padding(.top, 5)
						}
						.padding(.horizontal)
						.padding(.vertical, 5)
						
						Divider()
					}
					
					
				}
			}
		}
	}
}

#Preview {
    NotificationDetailView()
}
