//
//  CaseViewModel.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/13/25.
//

import Foundation
import SwiftUI

class CaseViewModel: ObservableObject {
	@Published var USCISCase: Case?

	init() {
//		fetchCaseInfo()
//		print("FEtched the Info")
	}
	
	func fetchCaseInfo() {
		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		
		guard let url = Bundle.main.url(forResource: "SampleResponse2", withExtension: "json") else {
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




