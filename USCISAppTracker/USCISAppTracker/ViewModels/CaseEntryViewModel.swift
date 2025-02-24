//
//  CaseEntryViewModel.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/20/25.
//

import Foundation

@Observable
class CaseEntryViewModel {
	let dataManager = DataManager.shared
	
	var casesData: [FetchedCase] = []
	
	/// Function in ViewModel to fetch all the Cases and corresponding status of the cases from server.
	// Call on when onAppear
	func fetchAllCases() async {
		casesData = await dataManager.fetchAllCasesData()
	}
	
	// Call this function on add, edit & delete
	private func getLatestCasesData() async {
		casesData = []
		await fetchAllCases()
	}
	
	// Add new case
	// Action on "Save" Button
//	func saveCase(receiptNumber: String, name: String, fetchDescriptor: FetchDescriptor<CaseEntry>) async -> String?{
//		if await dataManager.addCase(receiptNumber: receiptNumber, name: name, fetchDescriptor: fetchDescriptor) {
//			await getLatestCasesData()
//			return nil
//		} else {
//			return "Receipt Number already Exists. Try different number."
//		}
//	}
	
	// Edit the case
	// Action on "Edit" Button
//	func editCase(name: String, receiptNo: String, fetchDescriptor: FetchDescriptor<CaseEntry>) async -> Bool {
//		if await dataManager.updateCase(name: name, receiptNo: receiptNo, fetchDescriptor: fetchDescriptor) {
//			await getLatestCasesData()
//			return true
//		}
//		return false
//	}
	
	// Delete the case
//	func deleteCase(fetchDescriptor: FetchDescriptor<CaseEntry>) async -> Bool{
//		if await dataManager.deleteCase(fetchDescriptor: fetchDescriptor) {
//			await getLatestCasesData()
//			return true
//		}
//		return false
//	}
}
