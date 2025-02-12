//
//  ContentView.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/4/25.
//

import SwiftUI

struct ContentView: View {
	@Environment(\.isAddPage) var isAddPage
	@State var selectedCase: String?
	
    var body: some View {
		NavigationStack {
        ZStack {
				VStack {
					// MARK: Header
					HeaderView()
					
					ScrollView{
						// MARK: All Cases
						AllCasesView(selectedCase: $selectedCase)
						
						// MARK: News
						NewsView()
					}
				}
				.navigationDestination(item: $selectedCase) { caseName in
					SingleCaseDetailView()
						.toolbar(.hidden, for: .navigationBar)
						.transition(.move(edge: .trailing)) // Moves from right
						.environment(\.isAddPage, false) // changing the environment value to false
				}
			}
			.background(Color.antiFlashWhiteBaseColor)
        }
    }
}

#Preview {
    ContentView()
}
