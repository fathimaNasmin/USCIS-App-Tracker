//
//  USCISAppTrackerApp.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/4/25.
//

import SwiftUI

@main
struct USCISAppTrackerApp: App {
	@StateObject private var caseVm = CaseViewModel()
	
    var body: some Scene {
        WindowGroup {
            ContentView()
				.environmentObject(caseVm)
        }
    }
}
