//
//  AllCasesView.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/5/25.
//

import SwiftUI

struct AllCasesView: View {
	@Environment(\.isAddPage) var isAddPage
	@State var isAddNewCaseTabTapped: Bool = false
	@Binding var selectedCase: String?
	
    var body: some View {
			VStack {
				// MARK: Title - Cases
				HeadingView(headingText: "Cases")
				
				VStack {
					// MARK: TabView
					TabView {
						AddCaseOnTabView()
							.onTapGesture {
								isAddNewCaseTabTapped = true
								print(isAddPage)
							}
							.environment(\.isAddPage, true)
						
						SingleCaseView(statusColor: Color.processing, statusText: "Processing")
							.onTapGesture {
								selectedCase = "Processing"
							}
					}
					.tabViewStyle(.page)
					.indexViewStyle(.page(backgroundDisplayMode: .always))
					.background(.white)
					
				}
				.frame(maxWidth: .infinity)
				.frame(height: 220)
				.clipShape(RoundedRectangle(cornerRadius: 20))
				.shadow(color: .gray.opacity(0.3), radius: 10, x: 0, y: 4)
				.sheet(isPresented: $isAddNewCaseTabTapped) {
					NewCaseAddAndEditCaseView()
				}
			}
			.padding()
			.padding(.horizontal, 7)
    }
}

//#Preview {
//    AllCasesView()
//}

struct AddCaseOnTabView: View {
	var body: some View {
		VStack {
			HStack {
				Image(systemName: "document.badge.plus")
					.imageScale(.large)
				
				Text("Add New Case")
					.subTitleStyle(20)
			}
			.fontWeight(.bold)
			.foregroundColor(Color.tungstenGray)
			.padding(.bottom, 5)
			
			Text("Tap to add a new case")
				.subTitleStyle(14)
				.foregroundColor(Color.textGray)
		}
	}
}


