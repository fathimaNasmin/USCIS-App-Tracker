//
//  USCISCaseCache.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 3/1/25.
//

import Foundation

final class USCISCaseCache {
	static let shared = USCISCaseCache()
	
	var cacheDict: [String: FetchedCase] = [:]
	
	private init() {}
	
	/// Function to add case details to cache
	func setCaseDetails(_ details: FetchedCase) {
		cacheDict[details.data.receiptNo] = details
	}
	
	/// Function to retriece case details from cache
	func getCaseDetails(for receiptNumber: String) -> FetchedCase? {
		return cacheDict[receiptNumber]
	}
	
	/// Function to remove from the cache.
	func removeCaseDetails(for receiptNumber: String) {
		cacheDict.removeValue(forKey: receiptNumber)
	}
	
	/// Function to update change in Cache.
	func updateCache(for receiptNumber: String, name: String) {
		let data = getCaseDetails(for: receiptNumber)
		if let result = data {
			let updatedCase = FetchedCase(id: result.id, name: name, data: result.data, dateAdded: result.dateAdded)
			setCaseDetails(updatedCase)
		}
	}
}
