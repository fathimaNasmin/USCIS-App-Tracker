//
//  NewCaseAddView.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/6/25.
//

import SwiftUI
import SwiftData

struct NewCaseAddAndEditCaseView: View {
	@Environment(\.dismiss) var dismissAddCaseSheet
	@Environment(\.isAddPage) var isAddPage
	@Environment(\.modelContext) var context
	
	@State private var receiptNumber: String = ""
	@State private var nickName: String = ""
	
	@State private var isInfoButtonTapped: Bool = false
	
	private var isAddFieldValid: Bool {
		isReceiptNumberValid && isNameValid
	}
	
	private var isReceiptNumberValid: Bool {
		receiptNumber.count == 13 && checkReceiptNoPatternValid
	}
	
	private var isNameValid: Bool {
		!nickName.isEmpty && nickName.count > 3 ? true : false
	}
	
	// Computed Property for checking the Receipt Number Pattern
	private var checkReceiptNoPatternValid: Bool {
		do {
			let regExp = try Regex("[a-zA-Z]{3}[0-9]{10}")
			return try regExp.wholeMatch(in: receiptNumber) != nil
		} catch {
			print("Invalid Receipt number")
			return false
		}
	}
	
    var body: some View {
		VStack {
			HStack {
				Button("Cancel") {
					dismissAddCaseSheet()
				}
				.titleStyle(15)
				
				Spacer()
				
				Text(isAddPage ? "Add Case" : "Edit Case")
					.titleStyle(20)
				
				Spacer()
			}
			.padding()
			.padding(.vertical, 5)
			.background(.bluePrimary)
			.foregroundColor(.white)
			
			// MARK: New Case Form
			VStack {
				HStack {
					// MARK: TextField - Receipt Number
					TextField("", text: $receiptNumber, prompt: Text("Receipt Number").foregroundColor(Color.textGray))
						.textFieldStyle(RoundedRectangleTextFieldStyle())
						.padding(.vertical, 10)
						.overlay(alignment: .trailing) {
							if isAddPage {
								HStack {
									Spacer()
									Button(action: {
										withAnimation(.snappy(duration: 0.3)) {
											if isInfoButtonTapped { isInfoButtonTapped = false }
											else { isInfoButtonTapped = true }
										}
									}) {
										Image(systemName: "info.circle")
											.foregroundColor(.blue)
											.imageScale(.medium)
											.padding(.trailing, 10)
									}
								}
							}
						}
				}
				
				// MARK: TextField - Nick Name
				TextField("", text: $nickName, prompt: Text("Nick Name").foregroundColor(Color.textGray))
					.textFieldStyle(RoundedRectangleTextFieldStyle())
					.padding(.vertical, 10)
				
				Button {
					print("Save button pressed")
				} label: {
					Text("Save")
						.titleStyle(20)
						.padding()
						.padding(.vertical, -1)
						.frame(maxWidth: .infinity)
						.foregroundColor(.white)
						.background(.bluePrimary)
						.clipShape(RoundedRectangle(cornerRadius: 15))
				}
				.padding(.vertical, 10)
				.disabled(!isAddFieldValid)
				
			}
			.customBoxModifier(radius:15, x: 5, y: 5)
			.padding()
			.padding(.top)
			.overlay(alignment:.trailing) {
				if isInfoButtonTapped {
					InfoView(isInfoButtonTapped: $isInfoButtonTapped)
						.padding(.top, 80)
				}
			}
			
			
			Spacer()
		}
		.background(Color.antiflashwhite)
		.onTapGesture {
			withAnimation(.snappy(duration: 0.3)) {
				if isInfoButtonTapped {
					isInfoButtonTapped = false
				}
			}

		}
    }
}

//#Preview {
//	NewCaseAddAndEditCaseView()
//}



