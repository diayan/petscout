//
//  AccessTokenManagerTests.swift
//  PetScoutTests
//
//  Created by diayan siat on 07/06/2022.
//

import XCTest
@testable import PetScout

class AccessTokenManagerTests: XCTestCase {
    private var accessTokenManager: AccessTokenManagerProtocol?
    let token = AccessTokenTestHelper.randomAPIToken()
    
    override func setUp() {
        super.setUp()
        
        guard let userDefaults = UserDefaults(suiteName: #file) else {
            return
        }
        
        userDefaults.removePersistentDomain(forName: #file)
        userDefaults.set(token.expiresAt.timeIntervalSince1970, forKey: AppUserDefaultsKeys.expiresAt)
        userDefaults.set(token.bearerAccessToken, forKey: AppUserDefaultsKeys.bearerAccessToken)
        
        accessTokenManager = AccessTokenManager(userDefaults: userDefaults)
    }
    
    func test_requestToken() async throws {
        guard let token: String =
                accessTokenManager?.fetchToken() else {
                    XCTFail("Didn't get token from access token manager")
                    return
                }
        XCTAssertFalse(token.isEmpty)
    }

}
