//
//  UITableViewExt.swift
//  MovieList
//
//  Created by Zeeshan Tariq on 26/06/2021.
//
import UIKit

extension UITableView {
    
    func addRefreshControl(_ target: Any, action: Selector, tintColor: UIColor? = nil) {
        refreshControl = UIRefreshControl()
        refreshControl?.backgroundColor = UIColor.clear
        
        if tintColor != nil {
            refreshControl?.tintColor = tintColor!
        }
        refreshControl?.addTarget(target, action: action, for: .valueChanged)
    }
    
    func beginRefreshing() {
        self.refreshControl?.beginRefreshing()
    }
    func endRefreshing() {
        self.refreshControl?.endRefreshing()
    }
}


