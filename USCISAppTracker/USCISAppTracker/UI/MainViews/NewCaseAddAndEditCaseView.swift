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
	
	@State var receiptNumber: String = ""
	@State var nickName: String = ""
	@State private var alertMessage: String = ""
	
	@State private var isInfoButtonTapped: Bool = false
	@State private var showingAlert: Bool = false
	
	@State private var oldReceiptNo: String = ""
	@State private var oldName: String = ""
	
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
			return false
		}
	}
	
	private func receiptNumberExists(number: String, context: ModelContext) -> Bool {
		let fetchDescriptor = FetchDescriptor<CaseEntry>(predicate: #Predicate { $0.receiptNo == number })
		
		do {
			let results = try context.fetch(fetchDescriptor)
			return !results.isEmpty // It means exists
		}catch {
			print("Error on fetching: \(error.localizedDescription)")
			return false
		}
	}
	
	// Get Instance from the store
	private func getCaseEntryInstance() -> CaseEntry? {
		print(oldReceiptNo)
		let fetchDescriptor = FetchDescriptor<CaseEntry>(predicate: #Predicate { $0.receiptNo == oldReceiptNo })
		
		do {
			let results = try context.fetch(fetchDescriptor)
			print("Results: \(results)")
			return results.first
		}catch {
			print("Error on fetching: \(error.localizedDescription)")
			return nil
		}
	}
	
	private func saveNewCaseEntry() {
		if !receiptNumberExists(number: receiptNumber, context: context) {
			let newCase = CaseEntry(receiptNo: receiptNumber, name: nickName.capitalized)
			context.insert(newCase)
			do {
				try context.save()
				dismissAddCaseSheet()
			} catch {
				print(error.localizedDescription)
				showingAlert = true
				alertMessage = error.localizedDescription
			}
		} else {
			showingAlert = true
			alertMessage = "Receipt Number already Exists. Try different number."
		}
	}
	
	private func saveEditCaseEntry() {
		if let instance = getCaseEntryInstance() {
			instance.name = nickName.capitalized
			instance.receiptNo = receiptNumber
			
			do {
				try context.save()
				dismissAddCaseSheet()
			} catch {
				print(error.localizedDescription)
				showingAlert = true
				alertMessage = error.localizedDescription
			}
		}else {
			print("Result is nil")
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
					TextField("", text: $receiptNumber, prompt: Text("Receipt Number")
						.foregroundColor(Color.textGray))
						.textFieldStyle(RoundedRectangleTextFieldStyle())
						.textInputAutocapitalization(.characters)
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
				
				// Receipt Number: Error message
				HStack {
					Text(receiptNumber.count != 13 ? "Receipt Number should be exactly 13 characters" : "")
						.foregroundColor(.textGray)
						.captionStyle(10)
						.fontWeight(.bold)
					
					Spacer()
				}
				.padding(.top, -12)
				.padding(.leading, 5)
				
				// MARK: TextField - Nick Name
				TextField("", text: $nickName, prompt: Text("Nick Name").foregroundColor(Color.textGray))
					.textFieldStyle(RoundedRectangleTextFieldStyle())
					.padding(.vertical, 10)
					.autocorrectionDisabled(true)
				
				// Nick Name: Error message
				HStack {
					Text(nickName.count < 3 ? "Name should have atleast 3 characters" : "")
						.foregroundColor(.textGray)
						.captionStyle(10)
						.fontWeight(.bold)
					
					Spacer()
				}
				.padding(.top, -12)
				.padding(.leading, 5)
				
				
				Button {
					print("IsAddPage : \(isAddPage)")
					if isAddPage {
						// Call Save Function for adding new case
						saveNewCaseEntry()
					}else {
						// Call Save Function for editing existing case
						saveEditCaseEntry()
					}
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
				.alert(alertMessage, isPresented: $showingAlert) {
					Button("OK", role: .cancel) { }
				}
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
		.onAppear {
			oldReceiptNo = receiptNumber
			oldName = nickName
		}
    }
}

//#Preview {
//	NewCaseAddAndEditCaseView()
//}



