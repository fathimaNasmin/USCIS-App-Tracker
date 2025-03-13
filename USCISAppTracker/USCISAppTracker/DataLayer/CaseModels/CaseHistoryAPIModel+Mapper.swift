//
//  CaseHistoryAPI+Mapper.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/17/25.
//

// Computed Property returns a new History
extension CaseHistoryAPI {
	var history: Case.History {
		Case.History(date: formattedDate, text: completed_text_en, status: completed_text_en.convertToCaseStatus)
	}
}
