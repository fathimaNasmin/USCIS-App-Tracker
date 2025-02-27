//
//  CaseViewModel.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/13/25.
//

import Foundation
import SwiftUI

@Observable class CaseViewModel {
	var USCISCase: [FetchedCase] = []

	@ObservationIgnored let dataManager = DataManager.shared
	@ObservationIgnored let coreDataStack = CoreDataStack.shared
	
	let receiptNumberCharacterCount = 13
	let nameCharacterCount = 3
	
	init() {
		
	}
	
	func fetchCases() async {
		USCISCase = await dataManager.fetchCaseResults()
	}
	
	/// Function that fetches from local file
	func fetchStaticCaseInfo() -> Case{
		guard let url = Bundle.main.url(forResource: "SampleResponseWithHistory", withExtension: "json") else {
			fatalError("\'SampleResponse.json\' file not found in the bundle.")
		}
		
		do {
			let data = try Data(contentsOf: url)
			let decoder = JSONDecoder()
			return try decoder.decode(CaseAPIModel.self, from: data).domainModel
			
		}catch {
			fatalError("Failed to load or decode JSON format : \(error)")
		}
	}
	
	/// Save Button Action : Function that saves to the store
	func saveToDb(name: String, receiptNo: String) async {
		let newCaseEntry = CaseEntry(id: UUID(), name: name, receiptNo: receiptNo)
		await coreDataStack.save(newCaseEntry)
		await reloadLatestData()
		print("Saving complete...")
	}
	
	/// Edit button Action: Function that edit/ update the store
	func updateToDb(id: UUID, name: String?, receiptNo: String?) async {
		await coreDataStack.update(id: id, name: name, receiptNo: receiptNo)
		await reloadLatestData()
		print("Update complete...")
	}
	
	
	/// Delete button Action: Function that delete the store.
	func deleteToDb(id: UUID) {
		
	}
	
	/// Reload the data
	func reloadLatestData() async {
		do {
			try await Task.sleep(nanoseconds: 2 * 1_000_000_000)
			dataManager.loadCaseEntries()
			await fetchCases()
		}catch {
			print("Error on reloading the latest data")
		}

	}
	
	///  Function which checks the form validation
	func isAddFieldValid(name: String, receiptNo: String) -> Bool {
		print("isAddFieldValid called")
		let res = isReceiptNumberValid(receiptNo) && isNameValid(name)
		print(res)
		return res
	}
	
	private func isReceiptNumberValid(_ receiptNumber: String) -> Bool {
		receiptNumber.count == receiptNumberCharacterCount && checkReceiptNoPatternValid(receiptNumber)
	}
	
	private func checkReceiptNoPatternValid(_ receiptNumber: String) -> Bool {
		do {
			let regExp = try Regex("[a-zA-Z]{3}[0-9]{10}")
			return try regExp.wholeMatch(in: receiptNumber) != nil
		} catch {
			return false
		}
	}
	
	private func isNameValid(_ name: String) -> Bool {
		!name.isEmpty && name.count > 3 ? true : false
	}
}
