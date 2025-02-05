//
//  NewsView.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/5/25.
//

import SwiftUI

struct NewsView: View {
    var body: some View {
		VStack {
			// MARK: Title - News
			HStack {
				Text("News")
					.titleStyle(40)
					.foregroundColor(.black)
				Spacer()
			}
			
			ScrollView {
				ForEach(1...10, id: \.self) { view in
					SingleNewsView()
						.padding(.bottom, 20)
				}
			}
			.padding(5)
			.background(.clear)

		}
		.padding()
		.padding(.horizontal, 7)
    }
}

#Preview {
    NewsView()
}
