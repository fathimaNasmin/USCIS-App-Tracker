//
//  ContentView.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/4/25.
//

import SwiftUI

struct USCISPageView: View {
	@State private var vm = CaseViewModel()
	@State private var newsvm = NewsViewModel()
	@Environment(\.isAddPage) var isAddPage
	
	@State private var notificationBellTapped: Bool?
	@State var casevm: CaseViewModel = CaseViewModel()

	
    var body: some View {
		NavigationStack {
        ZStack {
				VStack {
					// MARK: Header
					HeaderView(notificationBellTapped: $notificationBellTapped)

					ScrollView{
						// MARK: All Cases
						AllCasesView(casevm: $casevm)
						
						// MARK: News
						NewsView(newsvm: $newsvm)
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
			Task {
				await casevm.loadOnAppear()
				newsvm.fetchNews()
			}
		}
    }
}

