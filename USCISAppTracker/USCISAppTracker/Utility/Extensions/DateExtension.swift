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
	
	var formatRelativeDate: String {
		let calendar = Calendar.current
		let now = Date()
		
		let dayDifference = calendar.dateComponents([.day], from: self, to: now).day ?? 0
		
		if calendar.isDateInToday(self) {
			let timeInterval = now.timeIntervalSince(self)
			let minutes = Int(timeInterval) / 60
			let hours = minutes / 60
			
			if minutes < 1 {
				return "Just now"
			} else if minutes < 60 {
				return "\(minutes) minutes ago"
			} else {
				return "\(hours) hours ago"
			}
		} else if calendar.isDateInYesterday(self) {
			return "Yesterday"
		} else if dayDifference < 7 {
			let formatter = DateFormatter()
			formatter.dateFormat = "EEEE"
			return formatter.string(from: self)
		} else if dayDifference < 3 {
			return "\(dayDifference) days ago"
		} else {
			let formatter = DateFormatter()
			formatter.dateStyle = .medium
			return formatter.string(from: self)
		}
	}
}
