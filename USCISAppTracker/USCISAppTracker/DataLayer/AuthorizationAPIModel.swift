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
	var issuedAt: Date {
		issued_at.timeEpoch
	}
	
	var expiresIn: Date {
		expires_in.timeEpoch
	}
	
	var expiresOn: Date {
		let doubleIssueAt = Double(issued_at)! / 1000
		let doubleExpiresIn = Double(expires_in)!
	
		let expirationTime = doubleIssueAt + doubleExpiresIn
		return Date(timeIntervalSince1970: expirationTime)
	}
}
