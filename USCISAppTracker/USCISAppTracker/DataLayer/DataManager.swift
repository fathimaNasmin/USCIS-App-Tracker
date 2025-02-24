//
//  DataManager.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/23/25.
//

import Foundation
import SwiftData

final class DataManager {
	static let shared = DataManager()
	
	private let apiService = CaseService()
	private let dataSource: SwiftDataService
	
	var storedCases: [CaseEntry] = []
	
	private init() {
		self.dataSource = SwiftDataService.shared 
		self.storedCases = dataSource.fetchAllCasesFromStore()
	}
	
	actor FetchedCasesStorage {
		private(set) var cases: [FetchedCase] = []
		
		func append(_ newCases: [FetchedCase]) {
			cases.append(contentsOf: newCases)
		}
	}
	
	let storage = FetchedCasesStorage()
	
	/// Function to fetch all the cases and corresponding status of the cases from server.
	func fetchAllCasesData() async -> [FetchedCase] {
		guard !storedCases.isEmpty else {
			print("No cases available in Swift Data")
			return []
		}
		
		var tempFetchedCases: [FetchedCase] = []
		
		await withTaskGroup(of: FetchedCase?.self) { group in
			for _case in storedCases {
				group.addTask { [weak self] in
					guard let self = self else { return nil }
					
					do {
						let response = try await self.apiService.fetchCaseStatus(for: _case.receiptNo)
						if let data = response {
							return FetchedCase(name: _case.name, data: data)
						}
						return nil
					} catch {
						print("Error on fetching data for \(_case.receiptNo): \(error.localizedDescription)")
						return nil
					}
				}
			}
			
			for await result in group {
				if let caseData = result {
					tempFetchedCases.append(caseData)
				}
			}
		}
		await storage.append(tempFetchedCases)
		return await storage.cases
	}

	
	/// Fetch updated data
	func getUpdatedDataFromStore() async {
		self.storedCases = dataSource.fetchAllCasesFromStore()
	}
	
	
	/// Funtion to  Add a new case to the store
	func addCase(receiptNumber: String, name: String, fetchDescriptor: FetchDescriptor<CaseEntry>) async -> Bool {
		return dataSource.addNewCaseEntry(receiptNumber: receiptNumber, name: name, fetchDescriptor: fetchDescriptor) 
	}
	
	/// Function to Edit the case in the Store
	func updateCase(name: String, receiptNo: String, fetchDescriptor: FetchDescriptor<CaseEntry>) async -> Bool {
		return dataSource.updateCaseEntry(name: name, receiptNo: receiptNo, fetchDescriptor: fetchDescriptor)
	}
	
	/// Function to  Delete the case from the store
	func deleteCase(fetchDescriptor: FetchDescriptor<CaseEntry>) async -> Bool{
		return dataSource.deleteCaseEntry(fetchDescriptor: fetchDescriptor) 
	}
}
