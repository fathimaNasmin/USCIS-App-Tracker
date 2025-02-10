//
//  DeleteCaseView.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/10/25.
//

import SwiftUI

struct DeleteCaseView: View {
    var body: some View {
		VStack {
			Button {
				print("delete the case")
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

		}
    }
}

#Preview {
    DeleteCaseView()
}
