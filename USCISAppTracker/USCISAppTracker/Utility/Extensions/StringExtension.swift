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
	
	var timeEpoch: Date {
		Date(timeIntervalSince1970: TimeInterval(Double(self)!))
	}
}





