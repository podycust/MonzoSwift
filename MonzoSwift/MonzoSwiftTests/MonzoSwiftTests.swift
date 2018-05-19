//
//  MonzoSwiftTests.swift
//  MonzoSwiftTests
//
//  Created by Jay Lees on 17/05/2018.
//  Copyright © 2018 jaylees. All rights reserved.
//

import XCTest
@testable import MonzoSwift

class MonzoSwiftTests: XCTestCase {
    private var testToken = ""
    private let timeout = 15.0
    
    // MARK: - Test Harness Setup
    override func setUp() {
        // We get the Monzo token from the Info.plist, Travis CI deals with this by using an environment variable and passing as an argument
        // Locally we use a shell script to place the token in the plist during the builds
        if let path = Bundle(for: MonzoSwiftTests.self).path(forResource: "Info", ofType: "plist"), let info = NSDictionary(contentsOfFile: path) as? [String: Any] {
            testToken = info["MonzoToken"] as? String ?? ""
        }
    }

    // MARK: - Account Retrieval
    func testGetAccounts(){
        let outcome = expectation(description: "Monzo returns a list of accounts associated with the token")
        let monzo = Monzo.instance
        monzo.setAccessToken(testToken)
        monzo.getAllAccounts { (result) in
            result.handle(self.fail, { (accounts) in
                XCTAssert(accounts.accounts.count >= 0)
            })
            outcome.fulfill()
        }
        waitForExpectations(timeout: timeout)
    }
    
    // MARK: - Account Balance
    func testGetBalance(){
        let outcome = expectation(description: "Monzo returns a list of accounts associated with the token")
        
        let monzo = Monzo.instance
        monzo.setAccessToken(testToken)
        //FIXME: Extract this to a "MockAccount" class
        monzo.getAllAccounts { (accountResponse) in
            accountResponse.handle(self.fail, { (accounts) in
                guard let account = accounts.accounts.first else {
                    XCTFail("No accounts available")
                    return
                }
                monzo.getBalance(for: account, callback: { (response) in
                    response.handle(self.fail, { (balance) in
                        print(balance.balance)
                        //TODO: Validate balance
                    })
                    outcome.fulfill()
                })
            })
        }
        waitForExpectations(timeout: timeout)
    }

    func fail(with error: Error) {
        XCTFail(error.localizedDescription)
    }
    
}
