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
	var issuedAt: Double? {
		if let issuedDate = Double(issued_at) {
			return issuedDate / 1000
		}
		return nil
	}
	
	var expiresIn: Double? {
		if let expiresTime = Double(expires_in) {
			return expiresTime
		}
		return nil
	}
	
	var expiresOn: Date? {
		if let issuedDate = issuedAt, let expiresTime = expiresIn {
			let expirationtime = issuedDate + expiresTime
			return Date(timeIntervalSince1970: expirationtime)
		}
		return nil
	}
}

