//
//  EnvironmentValuesExtension.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/11/25.
//

import Foundation
import SwiftUI

extension EnvironmentValues {
	@Entry var isAddPage: Bool = true
}


extension View {
	func isAddPage(_ isAddPage: Bool) -> some View {
		environment(\.isAddPage, isAddPage)
	}
}
