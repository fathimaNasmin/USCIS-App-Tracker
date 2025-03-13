//
//  NewsViewModel.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 3/13/25.
//

import Foundation

@Observable class NewsViewModel {
	var newsList: [News] = []
	
	func fetchNews() {
		let parser = NewsParser()
		parser.completionHandler = { news in
			self.newsList = news
		}
		parser.parseRssFeed()
		
	}
	
}
