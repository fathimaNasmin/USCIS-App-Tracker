//
//  StringExtension.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/17/25.
//
import Foundation

extension String {
	var iSODate: Date {
		let formatter = DateFormatter()
		formatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
		return formatter.date(from: self)!
		
	}
	
	var yearMonthDate: Date {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd"
		return formatter.date(from: self)!
	}
	
	var formattedESTDateString: Date? {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "E, dd MMM yy HH:mm:ss Z"
		dateFormatter.locale = Locale(identifier: "en_US_POSIX")
		
		// Convert the string to a Date object
		if let date = dateFormatter.date(from: self) {
			return date
		}
		return nil
	}
}





