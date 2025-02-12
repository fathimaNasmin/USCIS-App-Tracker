//
//  NewsView.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/5/25.
//

import SwiftUI

struct NewsView: View {
	@State var newsId: Int?
	
    var body: some View {
		NavigationStack {
			VStack {
				// MARK: Title - News
				HeadingView(headingText: "News")
				
				ScrollView {
					ForEach(1...5, id: \.self) { view in
						SingleNewsView(selectedNewsId: $newsId)
							.padding(.bottom, 20)
					}
				}
				.padding(5)
				.background(.clear)
				
			}
			.padding()
			.padding(.horizontal, 7)
			// navigation modifier'
			.navigationDestination(item: $newsId) { id in
				NewsDetailView()
					.toolbar(.hidden, for: .navigationBar)
					.transition(.move(edge: .trailing)) // Moves from right
			}
		}
    }
}

#Preview {
    NewsView()
}
