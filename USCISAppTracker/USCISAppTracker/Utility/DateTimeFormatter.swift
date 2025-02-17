//
//  Utilities.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/13/25.
//

import Foundation

func daySuffix(for day: Int) -> String {
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
