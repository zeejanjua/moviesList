//
//  MovieModel.swift
//  MovieList
//
//  Created by Zeeshan Tariq on 26/06/2021.
//

import UIKit

struct MoviesResponseModel : Codable {

    let statusCode: Int?
    let statusMessage: String?
    let page : Int?
    let results : [MovieModel]?
    let totalPages : Int?
    let totalResults : Int?


    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
        case page = "page"
        case results = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
}

struct MovieModel: Codable {
    
    let adult : Bool?
    let backdropPath : String?
    let genreIds : [Int]?
    let id : Int?
    let originalLanguage : String?
    let originalTitle : String?
    let overview : String?
    let popularity : Float?
    let posterPath : String?
    let releaseDate : String?
    let title : String?
    let video : Bool?
    let voteAverage : Double?
    let voteCount : Int?
    
    enum CodingKeys: String, CodingKey {
        case adult = "adult"
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id = "id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview = "overview"
        case popularity = "popularity"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title = "title"
        case video = "video"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    func getPosterURL() -> String {
        return "https://image.tmdb.org/t/p/w500\(posterPath ?? "")"
    }
}

