//
//  DeleteCaseView.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/10/25.
//

import SwiftUI

struct DeleteCaseView: View {
	@Environment(\.dismiss) private var dismiss
	@State private var showDeleteAlert: Bool = false

	let caseEntry: FetchedCase
	@Binding var casevm: CaseViewModel
	let receiptNum: String	
	
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
					Task {
						await casevm.deleteButtonTapped(receiptNumber: receiptNum)
					}
					dismiss()
				}
				Button("Cancel", role: .cancel) {
					print("Cancelled")
				}
			}

		}
    }
}


