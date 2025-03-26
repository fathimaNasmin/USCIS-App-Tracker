//
//  FetchError.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/22/25.
//

import Foundation

enum FetchError: Error, LocalizedError {
	case badResponse
	case unAuthorized
	case unknown
	
	var errorDescription: String? {
		switch self {
		case .badResponse:
			return "Bad response from the server."
		case .unAuthorized:
			return "Unauthorized: Provided credentials are invalid"
		case .unknown:
			return "An unknown error occurred."
		}
	}
}


enum CoreDataError: Error {
	case duplicateEntry
}

