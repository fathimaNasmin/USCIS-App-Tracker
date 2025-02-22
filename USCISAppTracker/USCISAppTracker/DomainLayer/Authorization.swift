//
//  Authorization.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/21/25.
//
import Foundation

struct Authorization {
	let tokenType: String
	let issuedTime: Date
	let accessToken: String
	let expiresIn: Date
	let status: String
	let futureExpiration: Date
}
