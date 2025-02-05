//
//  AllCasesView.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/5/25.
//

import SwiftUI

struct AllCasesView: View {
    var body: some View {
		GeometryReader { geo in
			VStack {
				// MARK: Title - Cases
				HStack {
					Text("Cases")
						.titleStyle(40)
					Spacer()
				}

				
				VStack {
					// MARK: TabView
					TabView {
						AddCaseOnTabView()
						Text("First")
						Text("Second")
						Text("Third")
						Text("Fourth")
					}
					.tabViewStyle(.page)
					.indexViewStyle(.page(backgroundDisplayMode: .always))
					.background(.white)
				}
				.frame(maxWidth: .infinity)
				.frame(height: 200)
				.clipShape(RoundedRectangle(cornerRadius: 20))
				.shadow(color: .gray.opacity(0.3), radius: 10, x: 0, y: 4)
			}
			.padding()
			.padding(.horizontal, 15)
		}
    }
}

#Preview {
    AllCasesView()
}

struct AddCaseOnTabView: View {
	var body: some View {
		VStack {
			HStack {
				Image(systemName: "document.badge.plus")
					.imageScale(.large)
				
				Text("Add New Case")
					.subTitleStyle(20)
			}
			.fontWeight(.bold)
			.foregroundColor(Color.darkGrayColor)
			.padding(.bottom, 5)
			
			Text("Tap to add a new case")
				.subTitleStyle(14)
				.foregroundColor(Color.textGray)
		}
	}
}


