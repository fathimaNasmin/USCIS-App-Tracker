//
//  FetchedCase.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/26/25.
//

import Foundation

class FetchedCase: NSObject, Identifiable {
	let id: UUID
	let name: String
	let dateAdded: Date
	let data: Case
	
	init(id: UUID, name: String, data: Case, dateAdded: Date) {
		self.id = id
		self.name = name
		self.data = data
		self.dateAdded = dateAdded
	}
}
