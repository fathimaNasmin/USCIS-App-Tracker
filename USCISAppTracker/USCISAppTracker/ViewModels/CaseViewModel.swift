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
	
}




