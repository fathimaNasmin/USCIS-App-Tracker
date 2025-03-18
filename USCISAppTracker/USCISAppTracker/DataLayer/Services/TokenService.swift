//
//  TokenService.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 3/18/25.
//

import Foundation
import KeychainSwift

class TokenService {
	static let shared = TokenService()
	private let keychain = KeychainSwift()
	
	var accessToken: String? {
		get { keychain.get("access_token") }
		
		set { keychain.set(newValue ?? "" , forKey: "access_token") }
	}
	
	var tokenExpiration: Date? {
		get {
			if let expirationString = keychain.get("token_expiration"){
				return DateFormatter().date(from: expirationString)
			}
			return nil
		}
		
		set {
			if let newValue = newValue {
				let newValueInString = DateFormatter().string(from: newValue)
				keychain.set(newValueInString, forKey: "token_expiration")
			}
		}
	}
	
	func isTokenValid() async -> Bool {
		if let tokenExpTime = tokenExpiration {
			return Date() < tokenExpTime
		}
		return false
	}
}
