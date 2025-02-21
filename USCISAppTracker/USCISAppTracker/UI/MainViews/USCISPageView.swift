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
	
	@State private var notificationBellTapped: Bool?
	
	
    var body: some View {
		NavigationStack {
        ZStack {
				VStack {
					// MARK: Header
					HeaderView(notificationBellTapped: $notificationBellTapped)

					ScrollView{
						// MARK: All Cases
						if vm.USCISCase != nil {

							AllCasesView(vm: vm)
						}
						// MARK: News
						NewsView()
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

