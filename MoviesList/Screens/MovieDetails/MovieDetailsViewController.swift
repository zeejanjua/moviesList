//
//  MovieDetailsViewController.swift
//  MovieList
//
//  Created by Zeeshan Tariq on 26/06/2021.
//

import UIKit
import WebKit

class MovieDetailsViewController: BaseController {
    
    //MARK: - Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!

    var viewModel = MovieDetailsViewModel()
    
    //MARK: - ViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBackButton()
        
        title = "Movie Details"
        
        viewModel.delegate = self
        
        populateViewWithData()
    }
    
    func populateViewWithData() {
        viewModel.fetchMovieDetails()
    }
    
    // MARK: - Button Actions
    @IBAction func didTapWatchTrailerButton() {
        if let urlString = viewModel.videoDataSource?[0].getVideoURL() {
            let videoVC = VideoPlayerViewController(nibName: String(describing: VideoPlayerViewController.self), bundle: nil)
            videoVC.viewModel.videoURLString = urlString
            //            let navigationVC = BaseNavController(rootViewController: videoVC)
            //            navigationVC.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
            //            self.present(navigationVC, animated: true, completion: nil)
            navigationController?.pushViewController(videoVC, animated: false)
        }
    }
    
}

// MARK: - MoviesViewModelDelegate
extension MovieDetailsViewController: MovieDetailsModelDelegate {
    func didLoadMovieDetails() {
        titleLabel.text = viewModel.dataSource?.title ?? ""
        overviewTextView.text = viewModel.dataSource?.overview ?? ""
        releaseDateLabel.text = viewModel.dataSource?.releaseDate ?? ""
        ImageHelper.setupImageForView(posterImage, url: viewModel.dataSource?.getPosterURL())
        
        var genreString = ""
        for (index, value) in (viewModel.dataSource?.genres ?? [Genre]()).enumerated() {
            genreString += value.name ?? ""
            genreString += index < ((viewModel.dataSource?.genres?.count ?? 0) - 2) ? " | " : ""
        }
        genresLabel.text  = genreString
    }
    
    func showLoader() {
        startLoading()
    }
    
    func hideLoader() {
        stopLoading()
    }

}
