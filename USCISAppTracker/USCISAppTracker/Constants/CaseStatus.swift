//
//  CaseStatus.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/14/25.
//

import SwiftUI

func getStatusStyle(for status: String) -> (color: Color, text: String) {
	let lowercasedStatus = status.lowercased()
	
	if lowercasedStatus.contains("affirmed") || lowercasedStatus.contains("approved") {
		return (Color.approved, "Approved")
	} else if lowercasedStatus.contains("travel authorization") || lowercasedStatus.contains("premium processing"){
		return (Color.processing, "Processing")
	} else if lowercasedStatus.contains("returned") || lowercasedStatus.contains("denied") {
		return (Color.rejected, "Action Required")
	} else {
		return (Color.delayed, "Unknown Status")
	}
}
