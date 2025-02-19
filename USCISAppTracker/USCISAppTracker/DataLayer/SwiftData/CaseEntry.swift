//
//  CaseEntry.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/18/25.
//

import Foundation
import SwiftData

@Model
final class CaseEntry: Identifiable {
	@Attribute(.unique) var id: String = UUID().uuidString
	@Attribute(.unique) var receiptNo: String
	var name: String
	
	init(receiptNo: String, name: String) {
		self.receiptNo = receiptNo
		self.name = name
	}
}



// TODO: Constraints on receiptNo [13 digits:- 3 character + 10 numbers]
// TODO: Validation on receiptNo
// TODO: Validation on name: more than 3 characters
// TODO: Disable "Save" button until pass the field validation
