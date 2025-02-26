//
//  FetchedCase.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/22/25.
//

import Foundation

struct CaseEntry: Identifiable, Hashable, Equatable {
	let id: UUID
	let name: String
	let receiptNo: String
}
