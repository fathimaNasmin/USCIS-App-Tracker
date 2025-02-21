//
//  AuthoorizationModel.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/13/25.
//

import Foundation

struct AuthorizationAPIModel: Codable {
	let token_type: String
	let access_token: String
	let status: String
}
