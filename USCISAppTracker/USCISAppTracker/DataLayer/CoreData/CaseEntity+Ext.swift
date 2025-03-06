//
//  CaseEntity+Ext.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/25/25.
//

import Foundation

extension CaseEntity {
	/// Function to convert CaseEntity(CoreData) to CaseEntry(Swift Model)
	func toCaseEntry() -> CaseEntry? {
		guard let id = self.id, let name = self.name, let receiptNo = self.receiptNo, let dateAdded = self.dateAdded
		else {
			return nil
		}
		
		return CaseEntry(id: id, name: name, receiptNo: receiptNo, dateAdded: dateAdded)
	}
}
