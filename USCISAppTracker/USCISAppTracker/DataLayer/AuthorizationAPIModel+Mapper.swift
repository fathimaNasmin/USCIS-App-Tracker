//
//  AuthorizationAPIModel+Mapper.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/21/25.
//


extension AuthorizationAPIModel {
	var authDomainModel: Authorization {
		return Authorization(tokenType: token_type, issuedTime: issuedAt, accessToken: access_token, expiresIn: expiresIn, status: status, futureExpiration: expiresOn)
	}
		
}
