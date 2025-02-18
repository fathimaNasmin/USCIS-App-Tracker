//
//  FontExtension.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/5/25.
//

import Foundation
import SwiftUI

extension Font {
	static func robotoMedium(_ size: CGFloat) -> Font {
		return .custom("Roboto-Medium", size: size)
	}
	
	static func robotoExtraLight(_ size: CGFloat) -> Font {
		return .custom("Roboto-ExtraLight", size: size)
	}
	
	static func robotoLight(_ size: CGFloat) -> Font {
		return .custom("Roboto-Light", size: size)
	}
	
	static func robotoRegular(_ size: CGFloat) -> Font {
		return .custom("Roboto-Regular", size: size)
	}
}
