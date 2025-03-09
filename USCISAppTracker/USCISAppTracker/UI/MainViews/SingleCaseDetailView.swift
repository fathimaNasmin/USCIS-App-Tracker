//
//  SingleCaseDetailView.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/6/25.
//

import SwiftUI

struct SingleCaseDetailView: View {
	@Environment(\.dismiss) var goBack
	@Environment(\.dismiss) var dismissEditPage
	@Environment(\.isAddPage) var isAddPage
	@State private var isEditCaseTapped: Bool = false

	let singleBoxDivision: CGFloat = 4
	let singleCaseDetail: FetchedCase
	@Binding var casevm: CaseViewModel
	
	var body: some View {
		GeometryReader { geo in
		VStack {
			// MARK: Header
			SubHeaderView(title: singleCaseDetail.name, iconName: "pencil") {
				isEditCaseTapped = true
			}
			
			// MARK: Contents
			ScrollView {
				VStack {
					// MARK: Receipt Number
					HStack{
						VStack(alignment: .leading){
							Text("Receipt Number")
								.captionStyle(12)
								.foregroundColor(Color.tungstenGray)
							Text(singleCaseDetail.data.receiptNo)
								.titleStyle(24)
								.fontWeight(.heavy)
								.foregroundColor(.bluePrimary)
						}
						
						Spacer()
					}
					.padding(.bottom, 20)
					
					
					// MARK: Latest Update on Case
					VStack {
						HStack{
							VStack{
								Text("Form")
									.padding(.bottom, 5)
									.subTitleStyle(16)
								Text(singleCaseDetail.data.formType)
									.subTitleStyle(20)
									.fontWeight(.bold)
							}
							.frame(width: geo.size.width / singleBoxDivision, height: geo.size.height / 8)
							.background {
								RoundedRectangle(cornerRadius: 10)
									.fill(.white)
									.stroke(.textGray.opacity(0.5), lineWidth: 2)
							}
							
							Spacer()
							
							VStack{
								Text("Submitted")
									.padding(.bottom, 5)
									.subTitleStyle(16)
								

								Text("\(String(describing: singleCaseDetail.data.daysFromNow!))")
									.subTitleStyle(20)
									.fontWeight(.bold)

								Text("days ago")
									.paragraphStyle(12)
							}
							.frame(width: geo.size.width / singleBoxDivision, height: geo.size.height / 8)
							.background {
								RoundedRectangle(cornerRadius: 10)
									.fill(.white)
									.stroke(.textGray.opacity(0.5), lineWidth: 2)
							}
							
							Spacer()
							
							VStack{
								Text("Updated")
									.padding(.bottom, 5)
									.subTitleStyle(16)
								
								Text("\(String(describing: singleCaseDetail.data.daysFromNow!))")
								.subTitleStyle(20)
								.fontWeight(.bold)


								Text("days ago")
									.paragraphStyle(12)
							}
							.padding()
							.frame(width: geo.size.width / singleBoxDivision, height: geo.size.height / 8)
							.background {
								RoundedRectangle(cornerRadius: 10)
									.fill(.white)
									.stroke(.textGray.opacity(0.5), lineWidth: 2)
							}
						}
						.frame(width:geo.size.width / 1.2, height: geo.size.height / 8)
						.padding(.bottom, 20)
						
						HStack{
							VStack(alignment: .leading){
								Text(singleCaseDetail.data.statusText)
									.titleStyle(22)
									.padding(.bottom, 10)
								// Formatting the HTML contents in response
								HTMLFormattedText(singleCaseDetail.data.statusDescription)
							}
						}
					}
					.customBoxModifier(opacity: 0.5, radius: 10, x: 2, y: 2)
					.padding(.bottom, 20)
					
					// MARK: Case history
					if !singleCaseDetail.data.history.isEmpty {
						CaseHistoryStatusView(caseStatusHistories: singleCaseDetail.data.history)
					}
					
					DeleteCaseView(caseEntry: singleCaseDetail, casevm: $casevm, receiptNum: singleCaseDetail.data.receiptNo)
						.padding(.top, 40)
				}
				.padding()
			}
		}
		.background(.antiflashwhite)
		.sheet(isPresented: $isEditCaseTapped) {
			NewCaseAddAndEditCaseView(currentCase: singleCaseDetail, casevm: $casevm)
		}
	}
}
}

