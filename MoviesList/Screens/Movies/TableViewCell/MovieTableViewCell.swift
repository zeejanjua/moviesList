//
//  MovieTableViewCell.swift
//  MovieList
//
//  Created by Zeeshan Tariq on 26/06/2021.
//

import UIKit
import Nuke


class MovieTableViewCell: UITableViewCell {
    
    //MARK:- Properties
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var poster: UIImageView!
    
    //MARK:- Cell Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    class func cellForTableView(_ tableView: UITableView, atIndexPath indexPath: IndexPath) -> MovieTableViewCell {
        let identifier = "MovieTableViewCell"
        tableView.register(UINib(nibName:"MovieTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MovieTableViewCell
        return cell
    }
    
    func configureCell(_ data: MovieModel) {
        title.text = data.title ?? ""
        subtitle.text = data.overview ?? ""
        rating.text = "\(data.voteAverage ?? 0.0)"
        ImageHelper.setupImageForView(poster, url: data.getPosterURL())
    }
    
}
