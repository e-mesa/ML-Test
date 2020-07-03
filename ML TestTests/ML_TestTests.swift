//
//  ML_TestTests.swift
//  ML TestTests
//
//  Created by Emiliano on 6/27/20.
//

import XCTest
@testable import ML_Test

class ML_TestTests: XCTestCase {
    
    var data: String!

    override func setUp() {
        data = loadJSON()
    }

    func testValidProductJson() {
        guard let products = Products(jsonString: data) else {
            XCTFail("Products map error")
            return
        }
        XCTAssertNotNil(products, "Products validation")
    }

    func testShippingInfo() {
        guard let products = Products(jsonString: data) else {
            XCTFail("Products ")
            return
        }
        XCTAssertNotNil(products, "Products validation")
    }

    func testProductInfo() {
        guard let products = Products(jsonString: data) else {
            XCTFail("Product info were not loaded")
            return
        }
        XCTAssertEqual(products.items?[0].id ?? "", "MLA865227261")
        XCTAssertEqual(products.items?[0].title ?? "", "iPhone 11 64 Gb Negro 4 Gb Ram")
        XCTAssertEqual(products.items?[0].price ?? 0, 149999)
        XCTAssertEqual(products.items?[0].thumbnail ?? "", "http://mla-s2-p.mlstatic.com/885508-MLA32445302787_102019-I.jpg")
        XCTAssertEqual(products.items?[0].condition ?? "", "new")
        XCTAssertEqual(products.items?[0].shipping.freeShipping ?? false, true)
    }
}

extension ML_TestTests {
    func loadJSON() -> String {
        let nameFile = "ProductSearch"
        let bundle = Bundle(for: type(of: self))
        return String.json(fromFile: nameFile, bundle: bundle)
    }
}


