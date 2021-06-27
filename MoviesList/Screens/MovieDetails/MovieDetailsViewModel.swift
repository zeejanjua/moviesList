//
//  MovieDetailsViewModel.swift
//  MovieList
//
//  Created by Zeeshan Tariq on 26/06/2021.
//


import Foundation

protocol MovieDetailsModelDelegate: BaseViewModelDelegate {
    func didLoadMovieDetails()
}


class MovieDetailsViewModel: BaseViewModel {

    var dataSource: MovieDetailsModel?
    var videoDataSource: [VideoModel]?
    
    var movieId = 0
    
    var delegate: MovieDetailsModelDelegate?
    
    func fetchMovieDetails() {
        
            delegate?.showLoader()
        
        let successBlock:DefaultAPISuccessClosure! = { response in
          
//                self.delegate?.hideLoader()
            
            //Update the records
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                let movieDetailsResponse = try JSONDecoder().decode(MovieDetailsModel.self, from: jsonData) //Decode JSON Response Data
                self.dataSource = movieDetailsResponse
                self.fetchVideos()
            } catch {
                // If there is no record, show empty message
            }
        }
        
        let failureBlock:DefaultAPIFailureClosure = { error in
    
                self.delegate?.hideLoader()
            // If there is no record, show empty message
        }
        
        let parameters:[String : Any] = ["api_key": Constants.movieApiKey]
        MovieAPIHandler.instance.getMovieDetails(movieId: movieId, parameters: parameters, success: successBlock, failure: failureBlock)
    }
    
    func fetchVideos() {
        
//        delegate?.showLoader()
        
        let successBlock:DefaultAPISuccessClosure! = { response in
            
            self.delegate?.hideLoader()
            
            //Update the records
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                let videosResponse = try JSONDecoder().decode(VideosResponseModel.self, from: jsonData) //Decode JSON Response Data
                self.videoDataSource = videosResponse.results ?? [VideoModel]()
                self.delegate?.didLoadMovieDetails()
            } catch {
                // If there is no record, show empty message
            }
        }
        
        let failureBlock:DefaultAPIFailureClosure = { error in
            
            self.delegate?.hideLoader()
            // If there is no record, show empty message
        }
        
        let parameters:[String : Any] = ["api_key": Constants.movieApiKey]
        MovieAPIHandler.instance.getVideos(movieId: movieId, parameters: parameters, success: successBlock, failure: failureBlock)
    }
}
