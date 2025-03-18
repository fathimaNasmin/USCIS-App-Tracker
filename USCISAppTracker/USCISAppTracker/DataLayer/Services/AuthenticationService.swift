//
//  AuthenticationService.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/21/25.
//

import Foundation

class AuthenticationService {
	
	private let tokenService = TokenService.shared
	
	func fetchAccessToken() async throws {
		// Define url
		let url = URL(string: ApiEndpoint.auth)!

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
		tokenService.accessToken = authorization.accessToken
		tokenService.tokenExpiration = authorization.futureExpiration
	}
}

