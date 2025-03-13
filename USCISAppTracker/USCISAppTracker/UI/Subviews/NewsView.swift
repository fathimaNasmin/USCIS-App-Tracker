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
				HStack {
					HeadingView(headingText: "News")
					Spacer()
					
					Button {
						print("View all")
					} label: {
						Text("View all")
							.titleStyle(16)
							.padding(6)
							.padding(.horizontal, 2)
							.foregroundColor(.white)
							.background(.bluePrimary)
							.clipShape(Capsule())
					}
				}
				
				ScrollView {
					ForEach(newsvm.newsList.prefix(3)) { currentNews in
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

