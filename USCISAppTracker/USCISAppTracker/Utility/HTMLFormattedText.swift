//
//  HTMLFormattedText.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/14/25.
//

import Foundation
import SwiftUI
import UIKit

struct HTMLFormattedText: UIViewRepresentable {
	
	let text: String
	private let textView = UITextView()
	
	init(_ content: String) {
		self.text = content
	}
	
	
	func makeUIView(context: UIViewRepresentableContext<Self>) -> UITextView {
		textView.widthAnchor.constraint(equalToConstant:UIScreen.main.bounds.width / 1.2).isActive = true
		textView.translatesAutoresizingMaskIntoConstraints = false
		textView.isScrollEnabled = false
		return textView
	}
	
	func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<Self>) {
		DispatchQueue.main.async {
			if let attributeText = self.convertHTML(text: text) {
				textView.attributedText = attributeText
				textView.textColor = UIColor.tungstenGray
				textView.font = UIFont(name: "Roboto-Light", size: 16) //("Roboto-Light", size: size)
			} else {
				textView.text = ""
			}
			
		}
	}
	
	private func convertHTML(text: String) -> NSAttributedString?{
		guard let data = text.data(using: .utf8) else {
			return nil
		}
		
		if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
			return attributedString
		} else{
			return nil
		}
	}
}
