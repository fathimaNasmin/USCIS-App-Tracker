//
//  CaseEntity+Ext.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/25/25.
//

import Foundation

extension CaseEntity {	
	/// Computed Property to convert CaseEntity(CoreData) to CaseEntry(Domain Model)
	var toCaseEntry: CaseEntry? {
		guard let id = self.id, let name = self.name, let receiptNo = self.receiptNo, let dateAdded = self.dateAdded
		else {
			return nil
		}
		
		return CaseEntry(id: id, name: name, receiptNo: receiptNo, dateAdded: dateAdded)
	}
}
