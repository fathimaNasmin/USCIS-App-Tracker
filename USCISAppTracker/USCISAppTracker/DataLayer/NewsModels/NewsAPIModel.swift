//
//  NewsAPIModel.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 3/13/25.
//

import Foundation

struct NewsAPIModel: Identifiable {
	let id: UUID
	let title: String
	let link: String
	let description: String
	let pubDate: String
	let source: String
}

extension NewsAPIModel {
	var publishedDate: Date? {
		return pubDate.formattedESTDateString ?? nil
	}
	
	var domainModel: News {
		let formattedDateString = publishedDate?.formatRelativeDate ?? nil
		return News(id: id, title: title, link: link, description: description, pubDate: formattedDateString, source: source)
	}
}

