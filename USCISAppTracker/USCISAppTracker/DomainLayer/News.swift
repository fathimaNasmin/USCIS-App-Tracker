//
//  News.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 3/13/25.
//

import Foundation

struct News: Identifiable {
	let id: UUID
	let title: String
	let link: String
	let description: String
	let pubDate: String?
	let source: String
}

extension News {
	var formattedDateText: String {
		pubDate ?? "invalid date"
	}

}
