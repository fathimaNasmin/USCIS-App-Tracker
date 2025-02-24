//
//  FetchedCase.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/22/25.
//

import Foundation

struct FetchedCase: Identifiable, Hashable, Equatable {
	let id = UUID().uuidString
	let name: String
	let data: Case
}
