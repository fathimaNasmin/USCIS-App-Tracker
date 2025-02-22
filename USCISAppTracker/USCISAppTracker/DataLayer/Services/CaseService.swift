//
//  FetchService.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/13/25.
//

import Foundation

struct CaseService {
	
	/// A Private Function to get the token
	private func getAccessToken() async -> String? {
		let authService = AuthenticationService.shared
		
		if !authService.isTokenValid() {
			do {
				try await authService.fetchAccessToken()
				return authService.accessToken
			}catch {
				print("")
			}
		} else {
			return authService.accessToken ?? nil
		}
		return nil
	}
	
	/// Function to fetch the case status
	func fetchCaseStatus(for receiptNo: String) async throws -> Case?{
		if let token = await getAccessToken() {
			var url = URL(string: ApiEndpoints.caseStatusEndpoint)!
			url = url.appending(path: receiptNo)
			
			var request = URLRequest(url: url)
			request.httpMethod = "GET"
			request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
			
			// Create a URLSession task
			let (data, response) = try await URLSession.shared.data(for: request)
			
			// Handle the response
			guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
				print("Fetch token: UnAuthorized")
				throw FetchError.unAuthorized
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
