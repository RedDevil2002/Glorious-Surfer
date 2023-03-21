//
//  Glorious_SurferTests.swift
//  Glorious SurferTests
//
//  Created by Brian Seo on 2023-03-14.
//

import XCTest
@testable import Glorious_Surfer
import ManagedSettings

final class Glorious_SurferTests: XCTestCase {

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddToBLockList() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        let model = Model.shared
        model.customDomainsToBlock = ["mobile.twitter.com", "twitter.com", "google.com", "netflix.com", "naver.com", "reddit.com"].compactMap { domain in
            WebDomain(domain: domain)
        }
        let currentCount = model.customDomainsToBlock.count
        model.addToBlockList(url: "http://safesurfer.io")
        XCTAssert(currentCount + 1 == model.customDomainsToBlock.count)
    }
    
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
