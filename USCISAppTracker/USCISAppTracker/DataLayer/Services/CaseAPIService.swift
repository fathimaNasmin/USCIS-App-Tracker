//
//  FetchService.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/13/25.
//

import Foundation

struct CaseAPIService {
	
	/// A Private Function to get the token
	private func getAccessToken() async -> String? {
		let authService = AuthenticationService.shared
		
		if authService.isTokenValid() {
			return authService.accessToken
		} else {
			try! await authService.fetchAccessToken()
			return authService.accessToken
		}
	}
	
	/// Function to fetch the case status
	func fetchCaseStatus(for receiptNo: String) async throws -> Case?{
		// check token is valid -> true .accesstoken ; false: fetchAccessToken
		if let token = await getAccessToken() {
			print("Token: \(token)")
			var url = URL(string: ApiEndpoints.caseStatusEndpoint)!
			url = url.appendingPathComponent(receiptNo)
			
			var request = URLRequest(url: url)
			request.httpMethod = "GET"
			request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
			
			// Create a URLSession task
			let (data, response) = try await URLSession.shared.data(for: request)
			
			// Handle the response
			guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
				print("Fetch token: Bad Response")
				throw FetchError.badResponse
			}
			do {
				let responseData = try JSONDecoder().decode(CaseAPIModel.self, from: data).domainModel
				return responseData
			}catch {
				return nil
			}
		}
		return nil
	}
}
