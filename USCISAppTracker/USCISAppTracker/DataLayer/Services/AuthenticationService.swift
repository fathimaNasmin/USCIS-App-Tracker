//
//  AuthenticationService.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/21/25.
//

import Foundation

struct AuthenticationService {
	private enum FetchError: Error {
		case badResponse
		case unAuthorized
	}
	
	func fetchAccessToken() async throws -> Authorization {
		// Define url
		let url = URL(string: ApiEndpoints.authEndpoint)!
		
		// Create the request
		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		
		// Set the headers
		request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
		
		// Set request body parameter
		let parameters = "grant_type=client_credentials&client_id=KuOw6BdkydJlDjfrDoiVbaS9onXm1gr0&client_secret=Ib6j8cNMfdTuWALQ"
		request.httpBody = parameters.data(using: .utf8)
		
		// Create a URLSession task
		let (data, response) = try await URLSession.shared.data(for: request)
		
		// Handle the response
		guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
			print("Fetch token: UnAuthorized")
			throw FetchError.unAuthorized
		}
		
		// Decode the response
		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		let authorization = try decoder.decode(AuthorizationAPIModel.self, from: data).authDomainModel
		return authorization
	}
}
