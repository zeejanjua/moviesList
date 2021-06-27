//
//  MovieListTests.swift
//  MovieListTests
//
//  Created by Zeeshan Tariq on 26/06/2021.
//

import XCTest
@testable import MoviesList

class MoviesListTests: XCTestCase {
    
    var controller: MoviesViewController!
    
    override func setUp() {
        controller = MoviesViewController(nibName: "MoviesViewController", bundle: .main)
        _ = controller.view
    }
    
    override func tearDown() {
        controller = nil
    }
    
    func testOutletBinding() {
        XCTAssertNotNil(controller?.tableView, "Connect tableView outlet")
        
        if let tableView = controller?.tableView {
            
            XCTAssertNotNil(tableView.delegate as? MoviesViewController, "TableView delegate not assigned")
            XCTAssertNotNil(tableView.dataSource as? MoviesViewController, "TableView dataSource not assigned")
        }
    }
    
    func testTableNoOfRowsBeforeAPICall() {
        XCTAssertEqual(controller.tableView.numberOfRows(inSection: 0), 0, "In the beggining, tableview should have no records")
    }
    
    func testMovieAPI()  {
        let expect = expectation(description: "Movie API response")
        
        let successBlock:DefaultAPISuccessClosure! = { response in
            XCTAssertNotNil(response, "Should always recieved some data in response");
            expect.fulfill()
        }
        
        let failureBlock:DefaultAPIFailureClosure = { error in
            XCTAssertNotNil(error, "Request failed with error : \(String(describing: error.localizedDescription))")
            expect.fulfill()
        }
        
        MovieAPIHandler.instance.getPopularMovies(parameters: ["api_key": Constants.movieApiKey, "page": 1], success: successBlock, failure: failureBlock)
        
        waitForExpectations(timeout: TimeInterval(120)){ error in
            XCTAssertNil(error, "Test timed out. \(String(describing: error?.localizedDescription))")
        }
    }
        
    func testMoviesCount()  {
        let expect = expectation(description: "Movie API response")
        
        let successBlock:DefaultAPISuccessClosure! = { response in
            if let jsonData = try? JSONSerialization.data(withJSONObject: response, options: .prettyPrinted), let moviesResponse = try? JSONDecoder().decode(MoviesResponseModel.self, from: jsonData), let movies = moviesResponse.results {
                XCTAssertNotEqual(movies.count, 0, "After successfull API Hit, records should be more")
            }
            expect.fulfill()
        }
        
        
        let failureBlock:DefaultAPIFailureClosure = { error in
            XCTAssertNotNil(error, "Request failed with error : \(String(describing: error.localizedDescription))")
            expect.fulfill()
        }
        
        MovieAPIHandler.instance.getPopularMovies(parameters: ["api_key": Constants.movieApiKey, "page": 1], success: successBlock, failure: failureBlock)
        
        waitForExpectations(timeout: TimeInterval(120)){ error in
            XCTAssertNil(error, "Test timed out. \(String(describing: error?.localizedDescription))")
        }
    }
    
}
