//
//  USCISAppTrackerApp.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/4/25.
//

import SwiftUI

@main
struct USCISAppTrackerApp: App {
    var body: some Scene {
        WindowGroup {
			USCISPageView()
				.modelContainer(for: CaseEntry.self)
        }
    }
}


// TODO: hide client_id and client_secret in env file
// TODO: store the bearer token -  keychain
