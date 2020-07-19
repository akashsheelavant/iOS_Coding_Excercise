//
//  FactsViewModelTests.swift
//  iOS_CodingTests
//
//  Created by Akash Sheelavant - Vendor on 7/19/20.
//  Copyright © 2020 Akash Sheelavant. All rights reserved.
//

import XCTest
import Foundation
@testable import iOS_Coding

class FactsViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // Verfiy that the title is as expected
    func testTitle() {
        // Given
        let mockNetworkManager = MockNetworkManager()
        let viewModel = FactsViewModel(networkManager: mockNetworkManager)

        // When
        let expectation = XCTestExpectation(description: "test load data")
        viewModel.fetchFacts { (status, errorMessage) in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)

        // Then
        XCTAssertEqual(viewModel.title, "About Canada")
    }

    // Verfiy number of rows are as expected
    func testNumberOfRows() {
        // Given
        let mockNetworkManager = MockNetworkManager()
        let viewModel = FactsViewModel(networkManager: mockNetworkManager)

        // When
        let expectation = XCTestExpectation(description: "test load data")
        viewModel.fetchFacts { (status, errorMessage) in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)

        // Then
        XCTAssertEqual(viewModel.facts.count, 14)

    }

    // verify the model at a given index matches the expected values
    func testModel() {
        // Given
        let mockNetworkManager = MockNetworkManager()
        let viewModel = FactsViewModel(networkManager: mockNetworkManager)

        // When
        let expectation = XCTestExpectation(description: "test load data")
        viewModel.fetchFacts { (status, errorMessage) in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)

        let emptyModel = viewModel.model(at: 7)
        let nonEmptyModel = viewModel.model(at: 10)

        // Then
        XCTAssertEqual(emptyModel?.title, nil)
        XCTAssertEqual(emptyModel?.description, nil)

        XCTAssertEqual(nonEmptyModel?.title, "Geography")
        XCTAssertEqual(nonEmptyModel?.description, "It's really big.")
    }

}

class MockNetworkManager: NetworkManagerType {
    func fetchFacts(completion: @escaping (Response?, String?) -> Void) {
        let bundle = Bundle(for: type(of: self))
        if let path = bundle.path(forResource: "facts", ofType: "json") {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) {
                let decoder = JSONDecoder()
                if let response = try? decoder.decode(Response.self, from: data) {
                    completion(response, nil)
                } else {
                    completion(nil, "Error loading response")
                }
            }
        }
    }
}
