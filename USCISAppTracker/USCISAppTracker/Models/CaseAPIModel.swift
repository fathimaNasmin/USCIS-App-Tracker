//
//  CaseResponseModel.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/13/25.
//

import Foundation
import SwiftUI


extension CaseAPIModel {
	struct CaseStatus: Decodable {
		let receiptNumber: String
		let formType: String
		let submittedDate: String
		let modifiedDate: String
		let currentCaseStatusText: String
		let currentCaseStatusDescription: String
		let caseHistoryStatus: [CaseHistoryAPI]?
		
		enum CodingKeys: String, CodingKey {
			case receiptNumber
			case formType
			case submittedDate
			case modifiedDate
			case currentCaseStatusText = "current_case_status_text_en"
			case currentCaseStatusDescription = "current_case_status_desc_en"
			case caseHistoryStatus = "hist_case_status"
		}
		
		var submitDate: Date {
			let formatter = DateFormatter()
			formatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
			return formatter.date(from: submittedDate)!
		}
		
		var modifyDate: Date {
			let formatter = DateFormatter()
			formatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
			return formatter.date(from: modifiedDate)!
		}
		
		var color: Color {
			let lowercasedStatus = currentCaseStatusText.lowercased()
			
			if lowercasedStatus.contains("affirmed") || lowercasedStatus.contains("approved") {
				return Color.approvedStatusColor
			} else if lowercasedStatus.contains("travel authorization") || lowercasedStatus.contains("premium processing"){
				return Color.processingStatusColor
			} else if lowercasedStatus.contains("returned") || lowercasedStatus.contains("denied") {
				return Color.rejectedStatusColor
			} else {
				return Color.delayedStatusColor
			}
		}
		
		var text: String {
			let lowercasedStatus = currentCaseStatusText.lowercased()
			
			if lowercasedStatus.contains("affirmed") || lowercasedStatus.contains("approved") {
				return "Approved"
			} else if lowercasedStatus.contains("travel authorization") || lowercasedStatus.contains("premium processing"){
				return "Processing"
			} else if lowercasedStatus.contains("returned") || lowercasedStatus.contains("denied") {
				return "Rejected"
			} else {
				return "Delayed"
			}
		}
		
	}
}

struct CaseAPIModel: Decodable {
	let caseStatus: CaseStatus
	
	enum CodingKeys: String, CodingKey{
		case caseStatus = "case_status"
	}
}


internal struct CaseHistoryAPI: Decodable {
	let date: String
	let completedDateEn: String
	
	enum CodingKeys: String, CodingKey {
		case date
		case completedDateEn = "completed_text_en"
	}
	
	var formattedDate: Date {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd"
		return formatter.date(from: date)!
	}
	
	var color: Color {
		let lowercasedStatus = completedDateEn.lowercased()
		
		if lowercasedStatus.contains("affirmed") || lowercasedStatus.contains("approved") {
			return Color.approvedStatusColor
		} else if lowercasedStatus.contains("travel authorization") || lowercasedStatus.contains("premium processing"){
			return Color.processingStatusColor
		} else if lowercasedStatus.contains("returned") || lowercasedStatus.contains("denied") {
			return Color.rejectedStatusColor
		} else {
			return Color.delayedStatusColor
		}
	}

	
	var history: History {
		History(date: formattedDate, text: completedDateEn, color: color)
	}
}


// API to Domian Mapper

extension CaseAPIModel {
	var domainModel: Case {
		return Case(
			receiptNo: caseStatus.receiptNumber,
			formType: caseStatus.formType,
			submittedDate: caseStatus.submitDate,
			lastUpdated: caseStatus.modifyDate,
			statusText: caseStatus.currentCaseStatusText,
			statusDescription: caseStatus.currentCaseStatusDescription,
			color: caseStatus.color,
			text: caseStatus.text,
			history: caseStatus.caseHistoryStatus?.compactMap { $0.history} ?? [])
	}
}




