//
//  AccessTokenTestHelper.swift
//  PetScoutTests
//
//  Created by diayan siat on 07/06/2022.
//

import Foundation
@testable import PetScout


enum AccessTokenTestHelper {
   
    //returns random string of length 8 from all alphabets
    static func randomString() -> String {
        let letters = "abcdefghijklmnopqrstuvwxyz"
        return String(letters.shuffled().prefix(8))
    }
    
    //return random api token using random string
    static func randomAPIToken() -> APIToken {
        return APIToken(
            tokenType: "Bearer",
            expiresIn: 10,
            accessToken: AccessTokenTestHelper.randomString()
        )
    }
    
    //generates random token data similar to when we get from the api
    static func generateValidToken() -> String {
    """
      {
        "token_type": "Bearer",
        "expires_in": 10,
        "access_token": \"\(randomString())\"
      }
      """
    }
}
