//
//  ContentView.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/4/25.
//

import SwiftUI

struct USCISPageView: View {
	@State private var vm = CaseViewModel()
	@Environment(\.isAddPage) var isAddPage
	
	@State private var selectedCase: String?
	@State private var notificationBellTapped: Bool?
	
	
    var body: some View {
		NavigationStack {
        ZStack {
				VStack {
					// MARK: Header
					HeaderView(notificationBellTapped: $notificationBellTapped)

					ScrollView{
						// MARK: All Cases
						if let normalCase = vm.USCISCase {

							AllCasesView(selectedCase: $selectedCase, oneCase: normalCase)
						}
						// MARK: News
						NewsView()
					}
				}
				.navigationDestination(item: $selectedCase) { caseName in
					if let casedetail = vm.USCISCase {
						SingleCaseDetailView(singleCase: casedetail)
							.toolbar(.hidden, for: .navigationBar)
							.transition(.move(edge: .trailing)) // Moves from right
							.environment(\.isAddPage, false) // changing the environment value to false
					}
				}
				.navigationDestination(item: $notificationBellTapped) { caseName in
					NotificationDetailView()
						.toolbar(.hidden, for: .navigationBar)
						.transition(.move(edge: .trailing)) // Moves from right
				}
			}
			.background(.antiflashwhite)
        }
		.onAppear {
			vm.fetchCaseInfo()
		}

    }
}

