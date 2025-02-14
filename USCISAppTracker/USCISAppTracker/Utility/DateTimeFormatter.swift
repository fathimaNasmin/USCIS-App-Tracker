//
//  Utilities.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/13/25.
//

import Foundation

private func daySuffix(for day: Int) -> String {
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


///  This function takes a date string as input, attempts to parse it using the expected format,
/// and then returns a formatted string with the correct ordinal suffix (`st`, `nd`, `rd`, `th`).
/// - Parameter date: A `String` representing a date in the format `"MM-dd-yyyy HH:mm:ss"`.
/// - Returns: A `String` representing the formatted date in `"d MMM yyyy"` format with the correct ordinal suffix.
/// If the input string is invalid, it returns `"invalid date"`.
func formatDateTime(date: String) -> String {
	let inputFormatter = DateFormatter()
	inputFormatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
	inputFormatter.locale = Locale(identifier: "en_US_POSIX")
	
	let outputFormatter = DateFormatter()
	outputFormatter.dateFormat = "MMM yyyy"
	outputFormatter.locale = Locale(identifier: "en_US")
	
	guard let parsedDate = inputFormatter.date(from: date) else {
		return "invalid date"
	}
	
	let calendar = Calendar.current
	let day = calendar.component(.day, from: parsedDate)
	let suffix = daySuffix(for: day)
	
	return "\(day)\(suffix) \(outputFormatter.string(from: parsedDate))"
}

func formatDate(date: String) -> String {
	let inputFormatter = DateFormatter()
	inputFormatter.dateFormat = "yyyy-MM-dd"
	inputFormatter.locale = Locale(identifier: "en_US_POSIX")
	
	let outputFormatter = DateFormatter()
	outputFormatter.dateFormat = "MMM yyyy"
	outputFormatter.locale = Locale(identifier: "en_US")
	
	guard let parsedDate = inputFormatter.date(from: date) else {
		return "invalid date"
	}
	
	let calendar = Calendar.current
	let day = calendar.component(.day, from: parsedDate)
	let suffix = daySuffix(for: day)
	
	return "\(day)\(suffix) \(outputFormatter.string(from: parsedDate))"
}

func daysFromNow(to dateString: String) -> Int? {
	let dateFormatter = DateFormatter()
	dateFormatter.dateFormat = "MM-dd-yyyy HH:mm:ss" // Match your date format
	dateFormatter.timeZone = TimeZone.current
	dateFormatter.locale = Locale.current
	
	// Convert string to Date
	guard let targetDate = dateFormatter.date(from: dateString) else { return nil }
	
	// Get current date without time
	let today = Calendar.current.startOfDay(for: Date())
	let targetDay = Calendar.current.startOfDay(for: targetDate)
	
	// Calculate difference in days
	let daysDifference = Calendar.current.dateComponents([.day], from: targetDay, to: today).day
	
	return daysDifference
}
