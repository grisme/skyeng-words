//
//  SkyengWordsTests.swift
//  SkyengWordsTests
//
//  Created by Eugene Garifullin on 10.07.2020.
//  Copyright © 2020 Grisme Team. All rights reserved.
//

import XCTest
@testable import SkyengWords

final class FakeNetworkService: Networking {
    
    /// Injection closure
    var performInjection: (@escaping RequestCompletion) -> Void = { completion in }
    
    /// Mocked perform request method
    func performRequest<Parameters: Encodable>(
        endpoint: String?,
        type: RequestType,
        params: Parameters?,
        completion: @escaping RequestCompletion
    ) {
        performInjection(completion)
    }
}

final class WordsServiceTest: XCTestCase {
    
    // MARK: - Properties
    
    /// Fake network service
    var networkService: FakeNetworkService = .init()

    // MARK: - Lifecycle
    
    /// Test initialiaztion
    override func setUpWithError() throws {
        networkService = FakeNetworkService()
    }

    override func tearDownWithError() throws {
    }
    
    // MARK: - Tests

    func testWordsServiceSearchRequestError() {
        
        // Mocking network service's completion
        networkService.performInjection = { completion in
            completion(.failure(.requestError(code: 400)))
        }
        
        // Building words service with faked network service
        let wordsService = WordsService(networkService: networkService)
        
        // When network service complete request with requestError
        var testResult: Result<[Word], WordsService.Error>?
        let expectedResult: Result<[Word], WordsService.Error> = .failure(.requestError(code: 400))
        wordsService.obtainWords(with: "", page: 1, pageSize: 10, completion: { result in
            testResult = result
        })
        
        // Result of the WordService's search method must be an error
        XCTAssertTrue(testResult == expectedResult, "WordsService should request error with same error code, when network service pass request error")
    }
    
    func testWordsServiceSearchInvalidData() {
        
        // Mocking network service's completion
        networkService.performInjection = { completion in
            let json = "{ someProperty = \"value\" }"
            let jsonData = json.data(using: .utf8)
            completion(.success(jsonData!))
        }
        
        // Building words service with faked network service
        let wordsService = WordsService(networkService: networkService)
        
        // When network service receives invalid data
        var testResult: Result<[Word], WordsService.Error>?
        let expectedResult: Result<[Word], WordsService.Error> = .failure(.invalidData)
        wordsService.obtainWords(with: "", page: 1, pageSize: 10, completion: { result in
            testResult = result
        })
        
        // Result of the WordService's search method must be an invalidData error
        XCTAssertTrue(testResult == expectedResult, "WordsService should pass invalidData, when network service receives unsupported data")
    }
    
}
