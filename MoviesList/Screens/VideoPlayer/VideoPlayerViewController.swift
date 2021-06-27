//
//  VideoPlayerViewController.swift
//  MovieList
//
//  Created by Zeeshan Tariq on 27/06/2021.
//

import UIKit
import WebKit


class VideoPlayerViewController: BaseController {
    
    //MARK: - Properties
    @IBOutlet weak var webView: WKWebView!
    
    var viewModel = VideoPlayerViewModel()
    
    //MARK: - ViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addDoneButton()
                
        title = "Movie Trailer"
        
        webView.uiDelegate = self
        webView.scrollView.delegate = self
        webView.scrollView.isMultipleTouchEnabled = false
        
        loadVideo()
    }
    
    func loadVideo() {
        
        // Create Video player
        
        if let myURL = URL(string: viewModel.videoURLString) {
            let youtubeRequest = URLRequest(url: myURL)
            webView?.load(youtubeRequest)
        }
    }

}

extension VideoPlayerViewController: WKUIDelegate, WKNavigationDelegate, UIScrollViewDelegate {
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        scrollView.pinchGestureRecognizer?.isEnabled = false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        stopLoading()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        stopLoading()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        startLoading()
    }
    
}
