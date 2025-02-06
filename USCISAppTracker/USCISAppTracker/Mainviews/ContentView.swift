//
//  ContentView.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/4/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
			VStack {
				// MARK: Header
				HeaderView()
				
				ScrollView{
					// MARK: All Cases
					AllCasesView()
					
					// MARK: News
					NewsView()
				}

				
//				Spacer()
			}
        }
		.background(Color.antiFlashWhiteBaseColor)
    }
}

#Preview {
    ContentView()
}
