//
//  CaseResponseModel.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/13/25.
//

import Foundation
import SwiftUI

struct CaseAPIModel: Decodable {
	let case_status: CaseDetail
}

extension CaseAPIModel {
	struct CaseDetail: Decodable {
		let receiptNumber: String
		let formType: String
		let submittedDate: String
		let modifiedDate: String
		let current_case_status_text_en: String
		let current_case_status_desc_en: String
		let hist_case_status: [CaseHistoryAPI]?
	}
}

// Computed Property for CaseStatus
extension CaseAPIModel.CaseDetail {
	var submitDate: Date {
		submittedDate.iSODate
	}
	
	var modifyDate: Date {
		modifiedDate.iSODate
	}
}

// HELPER
extension String {
	var convertToCaseStatus: Case.Status {
		let lowercasedStatus = self.lowercased()
		if lowercasedStatus.contains("affirmed") || lowercasedStatus.contains("approved") {
			return .approved
		} else if lowercasedStatus.contains("travel authorization") || lowercasedStatus.contains("premium processing"){
			return .processing
		} else if lowercasedStatus.contains("returned") || lowercasedStatus.contains("denied") {
			return .rejected
		} else {
			return .delayed
		}
	}
}


internal struct CaseHistoryAPI: Decodable {
	let date: String
	let completed_text_en: String
}

// Computed Properties of CaseHistoryAPI
extension CaseHistoryAPI {
	var formattedDate: Date {
		date.yearMonthDate
	}
}







