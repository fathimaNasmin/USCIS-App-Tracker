//
//  HeaderView.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/5/25.
//

import SwiftUI

struct HeaderView: View {
	@Binding var notificationBellTapped: Bool?
	
    var body: some View {
		HStack {
			Image("uscis_logo")
				.resizable()
				.frame(width: 70, height: 70)
			
			Spacer()
			
			Group {
				// MARK: Settings button
				Button {
					print("Settings tapped")
				} label: {
					Image(systemName: "gear")
				}
				
				// MARK: Notification button
				Button {
					print("Notification button")
					notificationBellTapped = true
				} label: {
					Image(systemName: "bell")
				}

			}
			.font(.title)
			.foregroundColor(.white)
			.padding(.trailing, 10)
		}
		.frame(maxWidth: .infinity)
		.padding()
		.background(Color.blueMainColor)
    }
}

//#Preview {
//    HeaderView()
//}
