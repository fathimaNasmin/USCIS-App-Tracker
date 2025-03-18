//
//  AuthorizationAPIModel+Mapper.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/21/25.
//

import Foundation


extension AuthorizationAPIModel {
	var authDomainModel: Authorization {
		return Authorization(tokenType: token_type, accessToken: access_token, status: status, futureExpiration: expiresOn ?? Date.now + 600)
	}
		
}
