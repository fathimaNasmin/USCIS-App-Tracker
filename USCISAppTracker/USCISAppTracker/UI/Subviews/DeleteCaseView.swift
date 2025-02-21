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
	let caseEntryvm: CaseEntryViewModel
	
	private func deleteCase() {
		let fetchDescriptor = FetchDescriptor<CaseEntry>(predicate: #Predicate { $0.receiptNo == receiptNo })
		if caseEntryvm.deleteCase(fetchDescriptor: fetchDescriptor) {
			dismiss()
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


