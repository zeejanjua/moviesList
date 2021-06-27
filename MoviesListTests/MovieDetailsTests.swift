//
//  MovieDetailsTests.swift
//  MovieListTests
//
//  Created by Zeeshan Tariq on 27/06/2021.
//

import XCTest
@testable import MoviesList


class MovieDetailsTests: XCTestCase {

    var controller: MovieDetailsViewController!
    
    override func setUp() {
        controller = MovieDetailsViewController(nibName: "MovieDetailsViewController", bundle: .main)
        _ = controller.view
    }
    
    override func tearDown() {
        controller = nil
    }
    
    func testOutletBinding() {
        XCTAssertNotNil(controller?.titleLabel, "Connect titleLabel outlet")
        XCTAssertNotNil(controller?.posterImage, "Connect posterImage outlet")
        XCTAssertNotNil(controller?.genresLabel, "Connect genresLabel outlet")
        XCTAssertNotNil(controller?.releaseDateLabel, "Connect releaseDateLabel outlet")
        XCTAssertNotNil(controller?.overviewTextView, "Connect overviewTextView outlet")
    }

    func testMovieDetailsAPI()  {
        let expect = expectation(description: "Movie Details API response")
        let successBlock:DefaultAPISuccessClosure! = { response in
            XCTAssertNotNil(response, "Should always recieved some data in response");
            expect.fulfill()
        }
        let failureBlock:DefaultAPIFailureClosure = { error in
            XCTAssertNotNil(error, "Request failed with error : \(String(describing: error.localizedDescription))")
            expect.fulfill()
        }
        
        MovieAPIHandler.instance.getMovieDetails(movieId: 297761, parameters: ["api_key": Constants.movieApiKey], success: successBlock, failure: failureBlock)
        
        waitForExpectations(timeout: TimeInterval(120)){ error in
            XCTAssertNil(error, "Test timed out. \(String(describing: error?.localizedDescription))")
        }
    }
    
    func testGetVideosAPI()  {
        let expect = expectation(description: "Get Videos API response")
        let successBlock:DefaultAPISuccessClosure! = { response in
            XCTAssertNotNil(response, "Should always recieved some data in response");
            expect.fulfill()
        }
        let failureBlock:DefaultAPIFailureClosure = { error in
            XCTAssertNotNil(error, "Request failed with error : \(String(describing: error.localizedDescription))")
            expect.fulfill()
        }
        
        MovieAPIHandler.instance.getVideos(movieId: 297761, parameters: ["api_key": Constants.movieApiKey], success: successBlock, failure: failureBlock)
        
        waitForExpectations(timeout: TimeInterval(120)){ error in
            XCTAssertNil(error, "Test timed out. \(String(describing: error?.localizedDescription))")
        }
    }
    
    func testVideosCount()  {
        let expect = expectation(description: "Get Videos API response")
        
        let successBlock:DefaultAPISuccessClosure! = { response in
            
            if let jsonData = try? JSONSerialization.data(withJSONObject: response, options: .prettyPrinted), let videosResponse = try? JSONDecoder().decode(VideosResponseModel.self, from: jsonData), let videos = videosResponse.results {
                XCTAssertNotEqual(videos.count, 0, "After successfull API Hit, records should be more")
            }
            expect.fulfill()
        }
        
        let failureBlock:DefaultAPIFailureClosure = { error in
            XCTAssertNotNil(error, "Request failed with error : \(String(describing: error.localizedDescription))")
            expect.fulfill()
        }
        
        MovieAPIHandler.instance.getVideos(movieId: 297761, parameters: ["api_key": Constants.movieApiKey], success: successBlock, failure: failureBlock)
        
        waitForExpectations(timeout: TimeInterval(120)){ error in
            XCTAssertNil(error, "Test timed out. \(String(describing: error?.localizedDescription))")
        }
    }
        
}
