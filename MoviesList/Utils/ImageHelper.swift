//
//  ImageHelper.swift
//  MovieList
//
//  Created by Zeeshan Tariq on 26/06/2021.
//

import Foundation
import Nuke

class ImageHelper {
    static func setupImageForView(_ imageView: UIImageView, url: String?) {
        let moviePosterPath = url ?? ""
        let request = ImageRequest(url: URL(string: moviePosterPath)!, processors: [
            ImageProcessors.RoundedCorners(radius: 21)
        ])
        
        let options = ImageLoadingOptions(placeholder: UIImage(named: "placeholder"),
                                          transition: .fadeIn(duration: 0.31),
                                          failureImage: UIImage(named: "placeholder"),
                                          contentModes: .init(success: .scaleAspectFit, failure: .scaleAspectFit, placeholder: .scaleAspectFit))
        
        Nuke.loadImage(with: request, options: options, into: imageView)
    }
}
