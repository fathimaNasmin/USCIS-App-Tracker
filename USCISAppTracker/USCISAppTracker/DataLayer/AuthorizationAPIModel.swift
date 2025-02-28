//
//  AuthoorizationModel.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/13/25.
//

import Foundation

struct AuthorizationAPIModel: Codable {
	let token_type: String
	let issued_at: String
	let access_token: String
	let expires_in: String
	let status: String
}


extension AuthorizationAPIModel {
	var issuedAt: Double {
		Double(issued_at)! / 1000
	}
	
	var expiresIn: Double {
		Double(expires_in)!
	}
	
	var expiresOn: Date {
		let expirationtime = issuedAt + expiresIn
		return Date(timeIntervalSince1970: expirationtime)
	}
}

