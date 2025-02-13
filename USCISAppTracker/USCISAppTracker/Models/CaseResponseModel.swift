//
//  CaseResponseModel.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/13/25.
//

import Foundation

struct CaseResponseModel: Codable {
	let caseStatus: CaseStatus
	
	struct CaseStatus: Codable {
		let receiptNumber: String
		let formType: String
		let submittedDate: String
		let modifiedDate: String
		let currentCaseStatusText: String
		let currentCaseStatusDescription: String
		let caseHistoryStatus: [CaseHistory]?
		
		enum CodingKeys: String, CodingKey {
			case receiptNumber
			case formType
			case submittedDate
			case modifiedDate
			case currentCaseStatusText = "current_case_status_text_en"
			case currentCaseStatusDescription = "current_case_status_desc_en"
			case caseHistoryStatus = "hist_case_status"
		}
		
		struct CaseHistory: Codable {
			let date: String
			let completedDateEn: String
			
			enum CodingKeys: String, CodingKey {
				case date
				case completedDateEn = "completed_text_en"
			}
		}
	}
}
