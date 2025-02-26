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
	
//	var storedCases: [CaseEntry] = []
	
	init() {
	}
	
	func loadStoredCases() {

	}
//
//	private let apiService = CaseService()
//	
//	var storedCases: [CaseEntry] = []
//	
//	private init() {
//		Task {
//			await loadStoredCases()
//		}
//	}
//	
//	private func loadStoredCases() async {
//		self.storedCases = await dataSource.fetchAllCasesFromStore()
//	}
//	
//	
//	actor FetchedCasesStorage {
//		private(set) var cases: [FetchedCase] = []
//		
//		func append(_ newCases: [FetchedCase]) {
//			cases.append(contentsOf: newCases)
//		}
//	}
//	
//	let storage = FetchedCasesStorage()
//	
//	/// Function to fetch all the cases and corresponding status of the cases from server.
//	func fetchAllCasesData() async -> [FetchedCase] {
//		guard !storedCases.isEmpty else {
//			print("No cases available in Swift Data")
//			return []
//		}
//		
//		var tempFetchedCases: [FetchedCase] = []
//		
//		await withTaskGroup(of: FetchedCase?.self) { group in
//			for _case in storedCases {
//				group.addTask { [weak self] in
//					guard let self = self else { return nil }
//					
//					do {
//						let response = try await self.apiService.fetchCaseStatus(for: _case.receiptNo)
//						if let data = response {
//							return FetchedCase(name: _case.name, data: data)
//						}
//						return nil
//					} catch {
//						print("Error on fetching data for \(_case.receiptNo): \(error.localizedDescription)")
//						return nil
//					}
//				}
//			}
//			
//			for await result in group {
//				if let caseData = result {
//					tempFetchedCases.append(caseData)
//				}
//			}
//		}
//		await storage.append(tempFetchedCases)
//		return await storage.cases
//	}
//
//	
//	/// Fetch updated data
//	func getUpdatedDataFromStore() async {
//		self.storedCases = await dataSource.fetchAllCasesFromStore()
//	}
//	
//	
//	/// Funtion to  Add a new case to the store
//	func addCase(receiptNumber: String, name: String, fetchDescriptor: FetchDescriptor<CaseEntry>) async -> Bool {
//		if await dataSource.addNewCaseEntry(receiptNumber: receiptNumber, name: name, fetchDescriptor: fetchDescriptor) {
//			await getUpdatedDataFromStore()
//			return true
//		}
//		return false
//	}
//	
//	/// Function to Edit the case in the Store
//	func updateCase(name: String, receiptNo: String, fetchDescriptor: FetchDescriptor<CaseEntry>) async -> Bool {
//		return await dataSource.updateCaseEntry(name: name, receiptNo: receiptNo, fetchDescriptor: fetchDescriptor)
//	}
//	
//	/// Function to  Delete the case from the store
//	func deleteCase(fetchDescriptor: FetchDescriptor<CaseEntry>) async -> Bool{
//		return await dataSource.deleteCaseEntry(fetchDescriptor: fetchDescriptor) 
//	}
}
