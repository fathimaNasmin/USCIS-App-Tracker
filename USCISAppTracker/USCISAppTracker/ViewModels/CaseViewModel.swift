//
//  CaseViewModel.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/13/25.
//

import Foundation
import SwiftUI

@Observable class CaseViewModel {
	var USCISCase: Case?

	init() {
	}
	
	func fetchCaseInfo() {
		guard let url = Bundle.main.url(forResource: "SampleResponseWithHistory", withExtension: "json") else {
			fatalError("\'SampleResponse.json\' file not found in the bundle.")
		}
		
		do {
			let data = try Data(contentsOf: url)
			let decoder = JSONDecoder()
			USCISCase = try decoder.decode(CaseAPIModel.self, from: data).domainModel
			
		}catch {
			fatalError("Failed to load or decode JSON format : \(error)")
		}
	}
	
}




