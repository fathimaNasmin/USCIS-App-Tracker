//
//  NewCaseAddView.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/6/25.
//

import SwiftUI

struct NewCaseAddAndEditCaseView: View {
	@Environment(\.dismiss) var dismissAddCaseSheet
	@Environment(\.isAddPage) var isAddPage
	
	@State var receiptNumber: String = ""
	@State var nickName: String = ""
	
	@State private var isInfoButtonTapped: Bool = false
	
	@State private var oldReceiptNo: String = ""
	@State private var oldName: String = ""
	
	let currentCase: FetchedCase?
	@Binding var casevm: CaseViewModel
	
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
					TextField("", text: isAddPage ? $receiptNumber : $oldReceiptNo, prompt: Text("Receipt Number")
						.foregroundColor(Color.textGray))
						.textFieldStyle(RoundedRectangleTextFieldStyle())
						.textInputAutocapitalization(.characters)
						.padding(.vertical, 10)
						.disabled(isAddPage ? false : true)
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
					Text(receiptNumber.count != casevm.receiptNumberCharacterCount ? "Receipt Number should be exactly \(casevm.receiptNumberCharacterCount) characters" : "")
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
					Text(nickName.count < casevm.nameCharacterCount ? "Name should have atleast \(casevm.nameCharacterCount) characters" : "")
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
						Task {
							if await casevm.saveButtonTapped(name: nickName, receiptNo: receiptNumber) != nil {
								dismissAddCaseSheet()
							}
						}
					} else {
						// Call Save Function for editing existing case
						print("Edit button tapped...")
						Task {
							if currentCase != nil {
								await casevm.editButtonTapped(name: nickName, receiptNo: receiptNumber)
							}
						}
						dismissAddCaseSheet()
					}
				} label: {
					Text("Save")
						.titleStyle(20)
						.titleStyle(20)
						.padding()
						.padding(.vertical, -1)
						.frame(maxWidth: .infinity)
						.foregroundColor(.white)
						.background(.bluePrimary)
						.clipShape(RoundedRectangle(cornerRadius: 15))
				}
				.padding(.vertical, 10)
				.disabled(!casevm.isAddFieldValid(name: nickName, receiptNo: receiptNumber))
				.alert(casevm.alertMessage, isPresented: $casevm.showAlert) {
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
			if !isAddPage {
				oldReceiptNo = currentCase?.data.receiptNo ?? ""
				oldName = currentCase?.name ?? ""
				receiptNumber = oldReceiptNo
				nickName = oldName
			}
		}
    }
}
