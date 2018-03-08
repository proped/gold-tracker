//
//  GoldPricesTest.swift
//  GoldTrackerTests
//
//  Created by Nattapon on 8/3/2561 BE.
//  Copyright © 2561 Nattapon. All rights reserved.
//

import XCTest

class GoldPricesTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testInit(){
        let goldPrices = GoldPrices()
        
        XCTAssertNil(goldPrices.first, "goldPrices.first should be nil")
        XCTAssertTrue(goldPrices.count == 0, "goldPrices.count should be 0")
        
    }
    
    func testSortByDESC() {
        let goldPrice_1 = GoldPrice()
        let goldPrice_2 = GoldPrice()
        let goldPrice_3 = GoldPrice()
        
        let goldPrices  = GoldPrices(array: [goldPrice_1,goldPrice_2,goldPrice_3])
        let result      = goldPrices.sortByDESC()
        
        XCTAssertTrue(result.count == 3, "goldPrices.count should be 3")
        
        XCTAssertTrue(result.lists[0].timestamp == goldPrice_3.timestamp, "goldPrices[0] value should be equal goldPrice_3")
        XCTAssertTrue(result.lists[1].timestamp == goldPrice_2.timestamp, "goldPrices[1] value should be equal goldPrice_2")
        XCTAssertTrue(result.lists[2].timestamp == goldPrice_1.timestamp, "goldPrices[2] value should be equal goldPrice_1")
        
    }
    
    func testInsertAndSortByDESC() {
        let goldPrice_1 = GoldPrice()
        let goldPrice_2 = GoldPrice()
        let goldPrice_3 = GoldPrice()
        
        let goldPrices  = GoldPrices(array: [goldPrice_1,goldPrice_2])
        let result      = goldPrices.insertAndSortByDESC(newData: goldPrice_3)
        
        XCTAssertTrue(result.count == 3, "goldPrices.count should be 3")
        
        XCTAssertTrue(result.lists[0].timestamp == goldPrice_3.timestamp, "goldPrices[0] value should be equal goldPrice_3")
        XCTAssertTrue(result.lists[1].timestamp == goldPrice_2.timestamp, "goldPrices[1] value should be equal goldPrice_2")
        XCTAssertTrue(result.lists[2].timestamp == goldPrice_1.timestamp, "goldPrices[2] value should be equal goldPrice_1")
        
    }
    
}
