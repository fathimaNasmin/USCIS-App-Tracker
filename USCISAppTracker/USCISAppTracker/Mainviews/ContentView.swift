//
//  ContentView.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/4/25.
//

import SwiftUI

struct ContentView: View {
	@State var selectedCase: String?
	
    var body: some View {
        ZStack {
			NavigationStack {
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
				}
			}
        }
		.background(Color.antiFlashWhiteBaseColor)
    }
}

#Preview {
    ContentView()
}
