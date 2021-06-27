//
//  MoviesViewController.swift
//  MovieList
//
//  Created by Zeeshan Tariq on 26/06/2021.
//

import UIKit
import NotificationBannerSwift
import ESPullToRefresh

class MoviesViewController: BaseController {
    
    //MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    lazy var searchBar = UISearchBar(frame: CGRect.zero)
    
    var viewModel = MoviesViewModel()
    
    //MARK: - ViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
            
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.customizeUI()
        
        viewModel.fetchMovies()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        viewModel.isSerachActive = false
    }
    
    func customizeUI() {
        
        setSearchBar()
        
        tableView.tableFooterView = UIView.init(frame: .zero)
        
        self.tableView.es.addPullToRefresh {
            [unowned self] in
            
            self.tableView.es.resetNoMoreData()
            
            viewModel.fetchMovies(pulledToRefresh: true)
        }
        self.tableView.es.addInfiniteScrolling {
            [unowned self] in
            
            viewModel.fetchMovies(pagination: true)
        }
    }
    
    func setSearchBar() {
        searchBar.placeholder = "Search Movie"
        searchBar.delegate = self
        searchBar.tintColor = .black
        navigationItem.titleView = searchBar
    }
    
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.backgroundView = nil
        return viewModel.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MovieTableViewCell.cellForTableView(tableView, atIndexPath: indexPath)
        cell.configureCell(viewModel.filteredDataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if tableView.isTracking { return }
        
        cell.contentView.alpha = 0.3
        cell.layer.transform = CATransform3DMakeScale(0.7, 0.7, 0.7)
        
        // Simple Animation
        UIView.animate(withDuration: 0.3) {
            cell.contentView.alpha = 1
            cell.layer.transform = CATransform3DScale(CATransform3DIdentity, 1, 1, 1)
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad {
            return 161
        }
        else {
            return 131
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let moviewDetailViewController = MovieDetailsViewController(nibName: String(describing: MovieDetailsViewController.self), bundle: nil)
        moviewDetailViewController.viewModel.movieId = viewModel.filteredDataSource[indexPath.row].id ?? 0
        self.navigationController?.pushViewController(moviewDetailViewController, animated: true)
    }

}


// MARK: - MoviesViewModelDelegate
extension MoviesViewController: MoviesViewModelDelegate {
    func showLoader() {
        startLoading()
    }
    
    func hideLoader() {
        stopLoading()
    }
    
    func didLoadMovies() {
        self.tableView.reloadData()
    }
    
    func stopPagination(){
        self.tableView.es.stopLoadingMore()
    }
    
    func noMoreData(){
        self.tableView.es.noticeNoMoreData()
        NotificationBanner.showTopBanner( "No more movies", style: .danger)
    }
    
    func stopPullToRefresh(){
        self.tableView.es.stopPullToRefresh(ignoreDate: true, ignoreFooter: false)
    }
    
    func showEmptyTableView(message: String) {
        Utility.emptyTableViewMessage(message: message, image: #imageLiteral(resourceName: "wIcon"), tableView: tableView)
    }
}

// MARK: - UISearchBarDelegate
extension MoviesViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        viewModel.isSerachActive = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterMovies(with: searchText)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        filterMovies(with: searchBar.text!)
        viewModel.isSerachActive = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        viewModel.isSerachActive = false
    }
    
    private func filterMovies(with searchText: String) {
        if searchText.isEmpty {
            viewModel.filteredDataSource = viewModel.dataSource
        } else {
            // filter data based on search bar search text
            viewModel.filteredDataSource = viewModel.dataSource.filter({ ($0.title ?? "").localizedCaseInsensitiveContains(searchText)
            })
        }
        
        tableView.reloadData()
        
        if viewModel.numberOfItems() == 0 {
            showEmptyTableView(message: Strings.noRecords.localized)
        }
    }
}

