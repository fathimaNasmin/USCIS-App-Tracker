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
	var showAlert: Bool = false
	var alertMessage: String = ""

	@ObservationIgnored let dataManager = DataManager.shared
	
	let receiptNumberCharacterCount = 13
	let nameCharacterCount = 3
	
	
	/// An Async function for loading on appear
	func loadOnAppear() async {
		await fetchCases()
		addAllCasesToCache()
	}
	
	/// Function that fetches cases and assign to a variable which is an Array of FetchedCase
	func fetchCases() async {
		USCISCase = await dataManager.fetchCaseResults()
	}
	
	// TODO: move this function to a background task
	/// Function to add fetched cases to cache.
	func addAllCasesToCache() {
		dataManager.addToCache(USCISCase)
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
	func saveButtonTapped(name: String, receiptNo: String) async -> Bool?{
		do {
			USCISCase = try await dataManager.saveToDb(name: name, receiptNo: receiptNo)
			return true
		} catch CoreDataError.duplicateEntry {
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
				self.alertMessage = "The Receipt Number you entered already exists.Try some other receipt Number."
				self.showAlert = true
			}
		} catch {
			DispatchQueue.main.async {
				self.alertMessage = "Something went wrong. Try again later."
				self.showAlert = true
			}
		}
		return nil
	}
	

	/// Edit button Action: Function that edit/ update the store
	func editButtonTapped(name: String, receiptNo: String) async {
		USCISCase = await dataManager.updateOnDb(name: name, receiptNo: receiptNo)
	}
	

	/// Delete button Action: Function that delete the store.
	func deleteButtonTapped(receiptNumber: String) async {
		USCISCase = await dataManager.deleteFromDb(receiptNumber: receiptNumber)
	}

	
	///  Function which checks the form validation
	func isAddFieldValid(name: String, receiptNo: String) -> Bool {
		let res = isReceiptNumberValid(receiptNo) && isNameValid(name)
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
