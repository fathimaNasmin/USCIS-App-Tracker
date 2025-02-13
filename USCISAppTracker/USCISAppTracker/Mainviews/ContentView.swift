//
//  ContentView.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/4/25.
//

import SwiftUI

struct ContentView: View {
	@Environment(\.isAddPage) var isAddPage
	
	@EnvironmentObject var caseVm: CaseViewModel
	
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
						AllCasesView(selectedCase: $selectedCase)
						
						// MARK: News
						NewsView()
					}
				}
				.navigationDestination(item: $selectedCase) { caseName in
					SingleCaseDetailView(caseVm: caseVm)
						.toolbar(.hidden, for: .navigationBar)
						.transition(.move(edge: .trailing)) // Moves from right
						.environment(\.isAddPage, false) // changing the environment value to false
				}
				.navigationDestination(item: $notificationBellTapped) { caseName in
					NotificationDetailView()
						.toolbar(.hidden, for: .navigationBar)
						.transition(.move(edge: .trailing)) // Moves from right
				}
			}
			.background(Color.antiFlashWhiteBaseColor)
        }
    }
}

#Preview {
    ContentView()
}
