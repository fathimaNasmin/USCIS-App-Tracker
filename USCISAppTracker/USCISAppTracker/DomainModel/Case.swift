//
//  Case.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/16/25.
//

import Foundation
import SwiftUI

// Domain Model or Business Model
struct Case {
	let receiptNo: String
	let formType: String
	let submittedDate: Date
	let lastUpdated: Date
	let statusText: String
	let statusDescription: String
	let color: Color
	let text: String
	let history: [History]
	
	var daysFromNow: Int? {
		// Get current date without time
		let today = Calendar.current.startOfDay(for: Date())
		let targetDay = Calendar.current.startOfDay(for: lastUpdated)
	
		// Calculate difference in days
		let daysDifference = Calendar.current.dateComponents([.day], from: targetDay, to: today).day
		return daysDifference
	}
	
	var formattedSubmitDate: String {
		let formatter = DateFormatter()
		formatter.dateFormat = "MMM yyyy"

		let calendar = Calendar.current
		let day = calendar.component(.day, from: submittedDate)
		let suffix = daySuffix(for: day)
		
		return "\(day)\(suffix) \(formatter.string(from: submittedDate))"
	}
}

struct History: Identifiable {
	let id: UUID = UUID()
	let date: Date
	let text: String
	let color: Color
	
	var formattedDate: String {
		let formatter = DateFormatter()
		formatter.dateFormat = "MMM yyyy"
		
		let calendar = Calendar.current
		let day = calendar.component(.day, from: date)
		let suffix = daySuffix(for: day)
		
		return "\(day)\(suffix) \(formatter.string(from: date))"
	}
}

