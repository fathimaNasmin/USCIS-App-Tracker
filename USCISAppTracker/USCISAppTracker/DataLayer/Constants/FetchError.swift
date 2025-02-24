//
//  FetchError.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/22/25.
//

import Foundation

enum FetchError: Error {
	case badResponse
	case unAuthorized
	case invalidCredentials
}

