//
//  AuthenticationService.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/21/25.
//

import Foundation
import KeychainSwift

class AuthenticationService{
	static let shared = AuthenticationService()
	
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
	
	func isTokenValid() -> Bool {
		if let tokenExpTime = tokenExpiration {
			return Date() < tokenExpTime
		}
		return false
	}
	
	func fetchAccessToken() async throws {
		// Define url
		let url = URL(string: ApiEndpoints.authEndpoint)!

		// Create the request
		var request = URLRequest(url: url)
		request.httpMethod = "POST"

		// Set the headers
		request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

		// Set request body parameter
		let parameters = "grant_type=client_credentials&client_id=\(Secrets.clientId)&client_secret=\(Secrets.clientSecret)"

		request.httpBody = parameters.data(using: .utf8)

		// Create a URLSession task
		let (data, response) = try await URLSession.shared.data(for: request)

		// Handle the response
		guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
			print("Fetch token from authaccesstoken: UnAuthorized")
			throw FetchError.unAuthorized
		}

		// Decode the response
		let authorization = try! JSONDecoder().decode(AuthorizationAPIModel.self, from: data).authDomainModel
		self.accessToken = authorization.accessToken
		self.tokenExpiration = authorization.futureExpiration
	}
}

