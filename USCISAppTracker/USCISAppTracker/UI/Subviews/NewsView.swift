//
//  NewsView.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/5/25.
//

import SwiftUI

struct NewsView: View {
	@State private var newsId: Int?
	@Binding var newsvm: NewsViewModel
	
    var body: some View {
		NavigationStack {
			VStack {
				// MARK: Title - News
				HeadingView(headingText: "News")
				
				ScrollView {
					ForEach(newsvm.newsList) { currentNews in
						SingleNewsView(selectedNewsId: $newsId, singleNews: currentNews)
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

