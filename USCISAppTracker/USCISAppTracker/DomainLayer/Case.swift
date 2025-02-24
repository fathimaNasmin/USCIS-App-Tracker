//
//  Case.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/16/25.
//

import Foundation
import SwiftUI

// Domain Model or Business Model
struct Case: Hashable, Equatable {
	let receiptNo: String
	let formType: String
	let submittedDate: Date
	let lastUpdated: Date
	let statusText: String
	let statusDescription: String
	let status: Case.Status
	let history: [History]
}

extension Case.Status {
	var color: Color {
		switch self {
		case .approved:
			return .approved
		case .processing:
			return .processing
		case .delayed:
			return .delayed
		case .rejected:
			return .rejected
		}
	}
}
extension Case {
	var daysFromNow: Int? {
		lastUpdated.daysDifference
	}
	
	var formattedSubmitDate: String {
		submittedDate.monthYear
	}
}

extension Case {
	enum Status: String {
		case approved
		case processing
		case delayed
		case rejected
	}
	
	struct History: Identifiable, Hashable, Equatable {
		let id: UUID = UUID()
		let date: Date
		let text: String
		let status: Case.Status

		var formattedDate: String {
			date.monthYear
		}
	}
}


