//
//  SingleCaseView.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/5/25.
//

import SwiftUI

struct SingleCaseView: View {
	let singleCase: Case
	
    var body: some View {
		VStack {
			HStack{
				CircleStatusView(width: 13, height: 13, circleColor: singleCase.color)
				
				Text(singleCase.text)
					.subTitleStyle(15)
					.foregroundColor(.black)
				
				Spacer()
			}
			.padding(.bottom, 10)
			.padding(.top, 5)
			
			HStack {
				Text("John Doe")
					.titleStyle(18)
					.foregroundColor(.black)
				
				Spacer()
			}
			.padding(.bottom, 3)
			
			HStack {
				Text(singleCase.receiptNo)
					.titleStyle(22)
					.fontWeight(.bold)
					.foregroundColor(Color.blueMainColor)
				
				Spacer()
				
				Text(singleCase.formattedSubmitDate)
					.captionStyle(12)
					.foregroundColor(.black)
			}
			.padding(.bottom, -2)
			
			HStack {
				Text(singleCase.statusText)
					.subTitleStyle(16)
					.fontWeight(.regular)
					.foregroundColor(.black)
				
				Spacer()
			}
			.padding(.bottom, 10)
			
			HStack{
//				if let date = vm.USCISCase {
					Text("Last status change: \(String(describing: singleCase.daysFromNow!)) days ago")
//				}
				Spacer()
				
				Text(singleCase.formType)
			}
			.captionStyle(12)
			.fontWeight(.regular)
			.foregroundColor(.textGray)

		}
		.padding()
		.padding(.horizontal, 0)
		.padding(.bottom, 40)
    }
}

