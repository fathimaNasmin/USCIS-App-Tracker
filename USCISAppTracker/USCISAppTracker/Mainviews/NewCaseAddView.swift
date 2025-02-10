//
//  NewCaseAddView.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/6/25.
//

import SwiftUI

struct NewCaseAddView: View {
	@Environment(\.dismiss) var dismissAddCaseSheet
	@State private var receiptNumber: String = ""
	@State private var nickName: String = ""
	@State var isInfoButtonTapped: Bool = false
	
	
    var body: some View {
		VStack {
			HStack {
				Button("Cancel") {
					dismissAddCaseSheet()
				}
				.titleStyle(15)
				
				Spacer()
				
				Text("Add Case")
					.titleStyle(20)
				
				Spacer()
			}
			.padding()
			.padding(.vertical, 5)
			.background(Color.blueMainColor)
			.foregroundColor(.white)
			
			// MARK: New Case Form
			VStack {
				HStack {
					TextField("", text: $receiptNumber, prompt: Text("Receipt Number").foregroundColor(Color.textGray))
						.textFieldStyle(RoundedRectangleTextFieldStyle())
						.padding(.vertical, 10)
						.overlay(alignment: .trailing) {
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
						.background(Color.blueMainColor)
						.clipShape(RoundedRectangle(cornerRadius: 15))
				}
				.padding(.vertical, 10)
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

#Preview {
	NewCaseAddView()
}



