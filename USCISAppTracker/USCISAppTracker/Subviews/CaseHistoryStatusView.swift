//
//  CaseHistoryStatusView.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/6/25.
//

import SwiftUI

struct CaseHistoryStatusView: View {
	let caseStatusHistories: [CaseHistory]
	
	@State private var circlePositions: [CGPoint] = []
	private let width: CGFloat = 12
	private let height: CGFloat = 12
	
	var body: some View {
		// MARK: Heading
		HeadingView(headingText: "Case History & Status", fontSize: 25)
		

		VStack(alignment: .leading) {
			ForEach(caseStatusHistories) { history in
				HStack(alignment: .top){
					
					CircleStatusView(width: width, height: height, circleColor: getStatusStyle(for: history.completedDateEn).color)
						.background(GeometryReader { proxy in
							Color.clear
								.preference(key: PositionPreferenceKey.self, value: [proxy.frame(in: .named("statusLineSpace")).midPoint])
						})
					
					HStack(alignment: .center) {
						VStack(alignment: .leading){
							Text(formatDate(date: history.date))
								.paragraphStyle(14)
								.fontWeight(.bold)
								.padding(.bottom, 2)
							
							Text(history.completedDateEn)
								.paragraphStyle(16)
							
						}
					}
				}
				.padding(.vertical, 10)
			}
		}
		.padding(.vertical, 10)
		.frame(maxWidth: .infinity, alignment: .leading)
		.customBoxModifier(opacity: 0.5, radius: 10, x: 2, y: 2)
		.coordinateSpace(name: "statusLineSpace")
		.onPreferenceChange(PositionPreferenceKey.self) { newValue in
			circlePositions = newValue
		}
		.overlay(
			GeometryReader { geo in
				Group {
					if circlePositions.count > 1 {
						ForEach(0..<circlePositions.count - 1, id: \.self) { index in
							
							let start = CGPoint(x: circlePositions[index].x, y: circlePositions[index].y + height / 2)
							
							let end = CGPoint(x: circlePositions[index + 1].x, y: circlePositions[index + 1].y - height / 2)
							
							Line(startPosition: start, endPosition: end)
								.stroke(style: StrokeStyle(lineWidth: 2))
								.foregroundColor(Color.textGrayColor.opacity(0.6))
							
						}
					}
				}
			}
		)
    }
}

//#Preview {
//    CaseHistoryStatusView()
//}


struct Line: Shape{
	let startPosition: CGPoint
	let endPosition: CGPoint

	func path(in rect: CGRect) -> Path {
		var path = Path()
		path.move(to: startPosition)
		path.addLine(to: endPosition)
		return path
	}
}


struct PositionPreferenceKey: PreferenceKey {
	static var defaultValue: [CGPoint] = []
	
	static func reduce(value: inout [CGPoint], nextValue: () -> [CGPoint]) {
		value.append(contentsOf: nextValue())
	}
}


extension CGRect {
	var midPoint: CGPoint {
		CGPoint(x: midX, y: midY)
	}
}

