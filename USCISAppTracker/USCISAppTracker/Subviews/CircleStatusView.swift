//
//  CircleStatusView.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/5/25.
//

import SwiftUI

struct CircleStatusView: View {
	let width: CGFloat
	let height: CGFloat
	let circleColor: Color
	
    var body: some View {
		Circle()
			.frame(width: width, height: height)
			.foregroundStyle(circleColor)
	}
}

#Preview {
	CircleStatusView(width: 12, height: 12, circleColor: Color.approvedStatusColor)
}
