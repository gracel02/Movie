//
//  APITests.swift
//  MovieTests
//
//  Created by Grace Liaw on 16/1/22.
//

import XCTest
@testable import Movie

class APITests: XCTestCase {
    let movieListVM = MovieListViewModel()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        try super.tearDownWithError()
    }
    
    func testFetchingPopularMovies() {
        let expectation = XCTestExpectation(description: "Wait for loading complete")
        let apiRequest = APIRequest(url: URL(string:"https://api.themoviedb.org/3/movie/popular?api_key=6b69aa48b6d27d02ad773aa94ed945bc&page=1")!)
        apiRequest.callRequest { result in
            expectation.fulfill()
            switch result {
            case .success(let movieInfo):
                XCTAssertNotNil(movieInfo.results, "Retrieved Popular movies")
            case .failure(_):
                XCTFail("Failed API Call")
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchingUpcomingMovies() {
        let expectation = XCTestExpectation(description: "Wait for loading complete")
        let apiRequest = APIRequest(url: URL(string:"https://api.themoviedb.org/3/movie/upcoming?api_key=6b69aa48b6d27d02ad773aa94ed945bc&page=1")!)
        apiRequest.callRequest { result in
            expectation.fulfill()
            switch result {
            case .success(let movieInfo):
                XCTAssertNotNil(movieInfo.results, "Retrieved Upcoming movies")
            case .failure(_):
                XCTFail("Failed API Call")
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }

}
