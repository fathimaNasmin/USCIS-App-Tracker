//
//  SingleCaseView.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/5/25.
//

import SwiftUI

struct SingleCaseView: View {
	@EnvironmentObject var caseVm: CaseViewModel
	
	let caseStatusText: String
	
    var body: some View {
		VStack {
			HStack{
				CircleStatusView(width: 13, height: 13, circleColor: getStatusStyle(for: caseStatusText).color)
				
				Text(getStatusStyle(for: caseStatusText).text)
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
				Text(caseVm.caseStatusResponse.caseStatus.receiptNumber)
					.titleStyle(22)
					.fontWeight(.bold)
					.foregroundColor(Color.blueMainColor)
				
				Spacer()
				
				Text(formatDateTime(date: caseVm.caseStatusResponse.caseStatus.submittedDate))
					.captionStyle(12)
					.foregroundColor(.black)
			}
			.padding(.bottom, -2)
			
			HStack {
				Text(caseVm.caseStatusResponse.caseStatus.currentCaseStatusText)
					.subTitleStyle(16)
					.fontWeight(.regular)
					.foregroundColor(.black)
				
				Spacer()
			}
			.padding(.bottom, 10)
			
			HStack{
				Text("Last status change: \(String(describing: daysFromNow(to: caseVm.caseStatusResponse.caseStatus.modifiedDate)!)) days ago")
				
				Spacer()
				
				Text(caseVm.caseStatusResponse.caseStatus.formType)
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

