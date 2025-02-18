//
//  DateExtension.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/17/25.
//
import Foundation

extension Date {
	private var daySuffix: String {
		let calendar = Calendar.current
		let day = calendar.component(.day, from: self)
		
		switch day {
		case 11, 12, 13: return "th"
		default:
			switch day % 10 {
			case 1: return "st"
			case 2: return "nd"
			case 3: return "rd"
			default: return "th"
			}
		}
	}
	
	var monthYear: String {
		let formatter = DateFormatter()
		formatter.dateFormat = "MMM yyyy"
		
		let calendar = Calendar.current
		let day = calendar.component(.day, from: self)
		let suffix = self.daySuffix
		
		return "\(day)\(suffix) \(formatter.string(from: self))"
	}
	
	var daysDifference: Int? {
		// Get current date without time
		let today = Calendar.current.startOfDay(for: Date())
		let targetDay = Calendar.current.startOfDay(for: self)
		
		// Calculate difference in days
		let daysDifference = Calendar.current.dateComponents([.day], from: targetDay, to: today).day
		return daysDifference
	}
	
}
