//
//  HeaderView.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/5/25.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
		HStack {
			Image("uscis_logo")
				.resizable()
				.frame(width: 70, height: 70)
			
			Spacer()
			
			Group {
				Image(systemName: "gear")
				Image(systemName: "bell")
			}
			.font(.title)
			.foregroundColor(.white)
			.padding(.trailing, 10)
		}
		.frame(maxWidth: .infinity)
		.padding()
		.background(Color.blueMainColor)
    }
}

#Preview {
    HeaderView()
}
