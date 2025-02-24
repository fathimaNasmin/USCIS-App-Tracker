//
//  SwiftDataService.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/20/25.
//

import Foundation
import SwiftData

class SwiftDataService {
	private let modelContainer: ModelContainer
	private let modelContext: ModelContext
	
	@MainActor
	static let shared = SwiftDataService()
	
	@MainActor
	private init() {
		do {
			self.modelContainer = try ModelContainer(for: CaseEntry.self,
													 configurations: ModelConfiguration(isStoredInMemoryOnly: false))
			self.modelContext = modelContainer.mainContext
		} catch {
			fatalError("Failed to create ModelContainer: \(error)")
		}
	}
	
	/// Function that fetches all the cases in persistance store
	func fetchAllCasesFromStore() -> [CaseEntry] {
		do {
			return try modelContext.fetch(FetchDescriptor<CaseEntry>())
		} catch {
			fatalError(error.localizedDescription)
		}
	}
	
	/// Function to add new case to the persistence store
	func addNewCaseEntry(receiptNumber: String, name: String, fetchDescriptor: FetchDescriptor<CaseEntry>) -> Bool{
		if !receiptNumberExists(number: receiptNumber, fetchDescriptor: fetchDescriptor) {
			let newCase = CaseEntry(receiptNo: receiptNumber, name: name.capitalized)
			modelContext.insert(newCase)
			do {
				try modelContext.save()
				return true
			} catch {
				fatalError(error.localizedDescription)
			}
		}
		// TODO: if the receipt number exists : show some alert
		else {
			return false
		}
	}
	
	/// Function to edit or Update case to the persistance store.
	func updateCaseEntry(name: String, receiptNo: String, fetchDescriptor: FetchDescriptor<CaseEntry>) -> Bool{
		if let instance = fetchCaseEntryInstance(fetchDescriptor: fetchDescriptor) {
			instance.name = name.capitalized
			instance.receiptNo = receiptNo
			
			do {
				try modelContext.save()
				return true
			} catch {
				print(error.localizedDescription)
			}
		}
		return false
	}
	
	
	/// Function to Delete the case from the persistance store.
	func deleteCaseEntry(fetchDescriptor: FetchDescriptor<CaseEntry>) -> Bool{
		if let instance = fetchCaseEntryInstance(fetchDescriptor: fetchDescriptor) {
			modelContext.delete(instance)
			do {
				try modelContext.save()
				return true
			} catch {
				print("Error saving context after deletion: \(error.localizedDescription)")
			}
		} else {
			print("No matching case entry found to delete.")
			return false
		}
		return false
	}
	
	
	/// Function to get or access the instance from the persistance store.
	private func fetchCaseEntryInstance<T>(fetchDescriptor: FetchDescriptor<T>) -> T? where T: PersistentModel {
		do {
			let results = try modelContext.fetch(fetchDescriptor)
			return results.first
		} catch {
			print("Error fetching cases: \(error.localizedDescription)")
			return nil
		}
	}
	
	
	/// Function to check whether already exists in persistance store.
	private func receiptNumberExists(number: String, fetchDescriptor: FetchDescriptor<CaseEntry>) -> Bool {
		do {
			let results = try modelContext.fetch(fetchDescriptor)
			return !results.isEmpty // It means exists
		}catch {
			print("Error on fetching: \(error.localizedDescription)")
			return false
		}
	}
	
}
