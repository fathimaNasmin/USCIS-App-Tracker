//
//  DeleteCaseView.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/10/25.
//

import SwiftUI
import SwiftData

struct DeleteCaseView: View {
	@Environment(\.dismiss) private var dismiss
	@Environment(\.modelContext) var context
	@State private var showDeleteAlert: Bool = false

	let receiptNo: String
	let name: String
	
	// Get Instance from the store
	private func getCaseEntryInstance() -> CaseEntry? {
		let fetchDescriptor = FetchDescriptor<CaseEntry>(predicate: #Predicate { $0.receiptNo == receiptNo })
		
		do {
			let results = try context.fetch(fetchDescriptor)
			print("Results: \(results)")
			return results.first
		}catch {
			print("Error on fetching: \(error.localizedDescription)")
			return nil
		}
	}
	
	private func deleteCase() {
		if let instance = getCaseEntryInstance() {
			context.delete(instance)
			do {
				try context.save()
				dismiss()
				print("Case entry deleted successfully.")
			} catch {
				print("Error saving context after deletion: \(error.localizedDescription)")
			}
		} else {
			print("No matching case entry found to delete.")
		}
	}
	
    var body: some View {
		VStack {
			Button {
				showDeleteAlert = true
			} label: {
				Text("Delete Case".uppercased())
					.titleStyle(20)
					.fontWeight(.bold)
					.padding(.vertical, 10)
					.frame(maxWidth: .infinity)
					.foregroundColor(.red)
					.padding(.horizontal, 60)
					.background(Color.textGray.opacity(0.3))
					.clipShape(RoundedRectangle(cornerRadius: 10))
			}
			.alert("Are you sure you want to delete this case", isPresented: $showDeleteAlert) {
				Button("Delete", role: .destructive) {
					// Call delete function
					deleteCase()
				}
				Button("Cancel", role: .cancel) {
					print("Cancelled")
				}
			}

		}
    }
}


