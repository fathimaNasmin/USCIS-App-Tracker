//
//  CaseViewModel.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/13/25.
//

import Foundation

class CaseViewModel: ObservableObject {
	@Published var caseStatusResponse: CaseResponseModel
	
	private let fetcher = FetchService()
	
	init() {
		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		
		guard let url = Bundle.main.url(forResource: "SampleResponse", withExtension: "json") else {
			fatalError("\'SampleResponse.json\' file not found in the bundle.")
		}
		
		do {
			let data = try Data(contentsOf: url)
			let decoder = JSONDecoder()
			caseStatusResponse = try decoder.decode(CaseResponseModel.self, from: data)
//			print(caseStatusResponse)
//			print(caseStatusResponse.caseStatus.caseHistoryStatus ?? [])
			
		}catch {
			fatalError("Failed to load or decode JSON format : \(error)")
		}
	}
}




