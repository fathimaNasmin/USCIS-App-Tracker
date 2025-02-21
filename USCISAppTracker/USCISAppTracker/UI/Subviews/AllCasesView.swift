//
//  AllCasesView.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/5/25.
//

import SwiftUI
import SwiftData

struct AllCasesView: View {
	@Environment(\.isAddPage) var isAddPage
	@State private var isAddNewCaseTabTapped: Bool = false
	@State var selectedCase: CaseEntry?
	
	@Environment(\.modelContext) var context
	@State var caseEntryvm: CaseEntryViewModel = CaseEntryViewModel(dataSource: .shared)
	
	let vm: CaseViewModel
	
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
								print("Stored Cases: \(caseEntryvm.storedCases)")
							}
							.environment(\.isAddPage, true)
						
						ForEach(caseEntryvm.storedCases) { _case in
							SingleCaseView(singleCase: vm.USCISCase!, caseEntry: _case)
								.onTapGesture {
									selectedCase = _case
								}
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
					NewCaseAddAndEditCaseView(caseEntryvm: caseEntryvm)
				}
			}
			.padding()
			.padding(.horizontal, 7)
			.navigationDestination(item: $selectedCase) { caseDetail in
				if let casedetail = vm.USCISCase {
					SingleCaseDetailView(singleCase: casedetail, caseEntry: caseDetail, caseEntryvm: caseEntryvm )
						.toolbar(.hidden, for: .navigationBar)
						.transition(.move(edge: .trailing)) // Moves from right
						.environment(\.isAddPage, false) // changing the environment value to false
				}
			}
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


