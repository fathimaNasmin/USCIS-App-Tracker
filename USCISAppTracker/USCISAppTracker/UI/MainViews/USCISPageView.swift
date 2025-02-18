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
					let _ = print("Update Vstack")

					ScrollView{
						// MARK: All Cases
						if let normalCase = vm.USCISCase {
							let _ = print("Update SpyView")

							AllCasesView(selectedCase: $selectedCase, oneCase: normalCase)
						}
						
						let _ = print("Update outside")

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

