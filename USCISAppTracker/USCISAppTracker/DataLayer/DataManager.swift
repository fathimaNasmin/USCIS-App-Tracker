//
//  DataManager.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/23/25.
//

import Foundation
import CoreData

final class DataManager {
	static let shared = DataManager()
	
	let apiService = CaseAPIService()
	
	var caseEntries: [CaseEntry] = []
	
	init() {
		caseEntries = CoreDataStack.shared.loadStoredCases()
	}
	
	/// Function that fetches the real data from server and store it in an array of type FetchedCase
	func fetchCaseResults() async -> [FetchedCase]{
		guard !caseEntries.isEmpty else {
			print("DB empty")
			return []
		}
		
		
		return await withTaskGroup(of:FetchedCase?.self) { group in
			var fetchedCases: [FetchedCase] = []
			
			for caseEntry in caseEntries {
				group.addTask {
					do {
						if let responseData = try await self.apiService.fetchCaseStatus(for: caseEntry.receiptNo) {
							return FetchedCase(id: caseEntry.id, name: caseEntry.name, data: responseData)
						}
						return nil
					}catch {
						print("Error on fetching case from data manager: \(error.localizedDescription)")
						return nil
					}
				}
			}
			
			for await result in group {
				if let caseResult = result {
						fetchedCases.append(caseResult)
				}
			}
			return fetchedCases
		}
	}
}
