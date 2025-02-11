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
	
	var body: some View {
		GeometryReader { geo in
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
				
				// Nick Name
				Text("John Doe")
					.titleStyle(20)
				
				Spacer()
				
				// Edit Button
				Button {
					print("Edit action")
					print(isAddPage)
					isEditCaseTapped = true
					
					
				} label: {
					Image(systemName: "pencil")
						.titleStyle(20)
						.fontWeight(.bold)
				}
				
			}
			.padding()
			.padding(.vertical, 5)
			.background(Color.blueMainColor)
			.foregroundColor(.white)
			
			ScrollView {
				VStack {
					// MARK: Receipt Number
					HStack{
						VStack(alignment: .leading){
							Text("Receipt Number")
								.captionStyle(12)
								.foregroundColor(Color.tungstenGray)
							Text("EAC9999103410")
								.titleStyle(24)
								.fontWeight(.heavy)
								.foregroundColor(Color.blueMainColor)
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
								Text("I-795")
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
								Text("450")
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
								Text("4")
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
								Text("Case Was Approved")
									.titleStyle(22)
									.padding(.bottom, 10)
								
								Text("On September 5, 2023, we approved your Form I-130, Petition for Alien Relative, Receipt Number EAC9999103403. We sent you an approval notice. Please follow the instructions in the notice.")
									.captionStyle(18)
									.lineSpacing(8)
									.foregroundColor(Color.tungstenGray)
									.padding(.bottom)
							}
						}
					}
					.customBoxModifier(opacity: 0.5, radius: 10, x: 2, y: 2)
					.padding(.bottom, 20)
					
					// MARK: Case history

					CaseHistoryStatusView()

					DeleteCaseView()
						.padding(.top, 40)
				}
				.padding()
			}
		}
		.background(Color.antiFlashWhiteBaseColor)
		.sheet(isPresented: $isEditCaseTapped) {
			NewCaseAddAndEditCaseView()
		}
	}
}
}

#Preview {
    SingleCaseDetailView()
}
