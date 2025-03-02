//
//  USCISCaseCache.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 3/1/25.
//

import Foundation

class USCISCaseCache {
	static let shared = USCISCaseCache()
	
	private let cache = NSCache<NSString, FetchedCase>()
	
	private init() {}
	
	/// Function to add case details to cache
	func setCaseDetails(_ details: FetchedCase){
		print("setting values to cache")
		cache.setObject(details, forKey: details.data.receiptNo as NSString)
	}
	
	/// Function to retriece case details from cache
	func getCaseDetails(for receiptNumber: String) -> FetchedCase? {
		print("getting values from cache")
		return cache.object(forKey: receiptNumber as NSString)
	}
	
	/// Function to remove from the cache.
	func removeCaseDetails(for receiptNumber: String) {
		cache.removeObject(forKey: receiptNumber as NSString)
	}
	
	/// Function to update change in Cache.
	func updateCache(for receiptNumber: String, name: String) {
		let data = getCaseDetails(for: receiptNumber)
		if let result = data {
			let updatedCase = FetchedCase(id: result.id, name: name, data: result.data)
			setCaseDetails(updatedCase)
		}
	}
}
