//
//  FetchedCase.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/26/25.
//

import Foundation

struct FetchedCase: Identifiable, Hashable, Equatable {
	let id: UUID
	let name: String
	let data: Case
}
