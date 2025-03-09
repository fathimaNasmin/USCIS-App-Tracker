//
//  DataManager.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/23/25.
//

import Foundation

final class DataManager {
	static let shared = DataManager()
	
	let apiService = CaseAPIService()
	let cache = USCISCaseCache.shared
	let coreDataStack = CoreDataStack.shared
	
	var caseEntries: [CaseEntry] = []
	
	init() {
		loadCaseEntries()
	}
	
	/// Function that loads data to the caseEntries
	func loadCaseEntries() {
		caseEntries = CoreDataStack.shared.loadStoredCases()
		print("CaseEntries: \(caseEntries)")
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
							return FetchedCase(id: caseEntry.id, name: caseEntry.name, data: responseData, dateAdded: caseEntry.dateAdded)
						}
						return nil
					}catch {
						print("Error on fetching case from data manager: \(error)")
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
	
	
	/// Function that fetches all the caseEntries details from cache if available, otherwise call the api 
	func loadDataFromCache() async -> [FetchedCase]? {
		var resultArray: [FetchedCase] = []
		// reload latest cases from core data
		loadCaseEntries()
		// reinitialize USCIS case [] from cache
		for _entry in caseEntries {
			if let res = cache.getCaseDetails(for: _entry.receiptNo) {
				resultArray.append(res)
			} else {
				// not in cache call for api service
				do {
					let apiRes = try await apiService.fetchCaseStatus(for: _entry.receiptNo)
					if let caseData = apiRes {
						let newCase = FetchedCase(id: UUID(), name: _entry.name, data: caseData, dateAdded: _entry.dateAdded)
						resultArray.append(newCase)
						// add to cache
						cache.setCaseDetails(newCase)
					}
				} catch {
					print("Error from loadDataFromCache: \(error)")
				}
			}
		}
		return resultArray
	}
	
	/// Function to add fetched cases to cache.
	func addToCache(_ allCases: [FetchedCase]) {
		for _case in allCases {
			cache.setCaseDetails(_case)
		}
	}
	
	/// Save Button Action : Function that saves to the store
	func saveToDb(name: String, receiptNo: String) async throws -> [FetchedCase] {
		let newCaseEntry = CaseEntry(id: UUID(), name: name, receiptNo: receiptNo, dateAdded: Date())
		do {
			try await coreDataStack.save(newCaseEntry)
		} catch CoreDataError.duplicateEntry {
			print("Error: Item already exists in the store.")
			throw CoreDataError.duplicateEntry
		}catch {
			print("Unexpected error: \(error)")
		}
		return await reloadLatestData()
	}
	
	/// Edit button Action: Function that edit/ update the store
	func updateOnDb(name: String, receiptNo: String) async -> [FetchedCase] {
		await coreDataStack.update(name: name, receiptNo: receiptNo)
		cache.updateCache(for: receiptNo, name: name)
		return await reloadLatestData()
	}
	

	/// Delete button Action: Function that delete the store.
	func deleteFromDb(receiptNumber: String) async -> [FetchedCase] {
		await coreDataStack.delete(receiptNumber)
		// remove from cache
		cache.removeCaseDetails(for: receiptNumber)
		return await reloadLatestData()
	}
	
	/// Reload the data
	private func reloadLatestData() async -> [FetchedCase] {
		do {
			try await Task.sleep(nanoseconds: UInt64(0.5) * 1_000_000_000)
			if let fetchedCaseResult = await loadDataFromCache() {
				return fetchedCaseResult
			}
		}catch {
			print("Error on reloading the latest data")
			return []
		}
		return []
	}
}
