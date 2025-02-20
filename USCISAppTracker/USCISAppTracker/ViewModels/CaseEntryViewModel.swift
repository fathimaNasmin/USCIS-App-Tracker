//
//  CaseEntryViewModel.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/20/25.
//

import Foundation
import SwiftData

@Observable
class CaseEntryViewModel {
	var storedCases: [CaseEntry] = []
	
	@ObservationIgnored
	private let dataSource: SwiftDataService
	
	init(dataSource: SwiftDataService) {
		self.dataSource = dataSource
		
		storedCases = dataSource.fetchAllCases()
	}
	
	// Add new case
	func addCase(receiptNumber: String, name: String, fetchDescriptor: FetchDescriptor<CaseEntry>) -> Bool {
		storedCases = dataSource.fetchAllCases()
		return dataSource.addNewCaseEntry(receiptNumber: receiptNumber, name: name, fetchDescriptor: fetchDescriptor)
	}
	
	// Edit the case
	func updateCase(name: String, receiptNo: String, fetchDescriptor: FetchDescriptor<CaseEntry>) -> Bool {
		return dataSource.updateCaseEntry(name: name, receiptNo: receiptNo, fetchDescriptor: fetchDescriptor)
	}
	
	// Delete the case
	func deleteCase(fetchDescriptor: FetchDescriptor<CaseEntry>) -> Bool{
		return dataSource.deleteCaseEntry(fetchDescriptor: fetchDescriptor)
	}	
}


// TODO: after deletion the storedCases is not refreshing
// TODO: after adding not refreshing
