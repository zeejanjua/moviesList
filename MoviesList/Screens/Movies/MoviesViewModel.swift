//
//  MoviesViewModel.swift
//  MovieList
//
//  Created by Zeeshan Tariq on 26/06/2021.
//

import Foundation

protocol MoviesViewModelDelegate: BaseViewModelDelegate {
    func didLoadMovies()
    func showEmptyTableView(message: String)
    func stopPagination()
    func noMoreData()
    func stopPullToRefresh()
}

class MoviesViewModel: BaseViewModel {

    var dataSource = [MovieModel]()
    var filteredDataSource = [MovieModel]()
    var isSerachActive = true
    var currentPage = 1
    var minLimitOfPages = 1
    var maxLimitOfPages = 1
        
    var delegate: MoviesViewModelDelegate?
    
    func numberOfItems() -> Int {
        return self.filteredDataSource.count
    }
    
    func fetchMovies(pulledToRefresh: Bool = false, pagination: Bool = false) {
                
        
        let successBlock:DefaultAPISuccessClosure! = { response in
            
            if pulledToRefresh || pagination {
                self.delegate?.stopPullToRefresh()
                self.delegate?.stopPagination()
            }
            else {
                self.delegate?.hideLoader()
            }
            
            //Update the records
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                let moviesResponse = try JSONDecoder().decode(MoviesResponseModel.self, from: jsonData) //Decode JSON Response Data
                self.dataSource = moviesResponse.results ?? [MovieModel]()//.append(contentsOf: moviesResponse.results ?? [MovieModel]())
                self.filteredDataSource = self.dataSource
                self.maxLimitOfPages = moviesResponse.totalPages ?? 1
                if self.dataSource.count == 0 {
                    // If there is no record, show empty message
                    self.delegate?.showEmptyTableView(message: Strings.noRecords.localized)
                }
                else {
                    self.delegate?.didLoadMovies()
                }
            } catch {
                // If there is no record, show empty message
                self.delegate?.showEmptyTableView(message: Strings.noRecords.localized)
            }
        }
        
        let failureBlock:DefaultAPIFailureClosure = { error in
            if pulledToRefresh || pagination {
                self.delegate?.stopPullToRefresh()
                self.delegate?.stopPagination()
            }
            else {
                self.delegate?.hideLoader()
            }
            // If there is no record, show empty message
            self.delegate?.showEmptyTableView(message: Strings.noRecords.localized)
        }
        
        
        if pulledToRefresh, currentPage > minLimitOfPages {
            currentPage -= 1
        }
        else if pagination, currentPage < maxLimitOfPages  {
            currentPage += 1
        }
        else if (pulledToRefresh || pagination) && isSerachActive {
            self.delegate?.stopPullToRefresh()
            self.delegate?.stopPagination()
            self.delegate?.noMoreData()
            return
        }
        else {
            self.delegate?.showLoader()
        }
        
        let parameters:[String : Any] = ["api_key": Constants.movieApiKey, "page": currentPage.description]
        MovieAPIHandler.instance.getPopularMovies(parameters: parameters, success: successBlock, failure: failureBlock)
    }
}

