//
//  MovieModel.swift
//  Taimur Mushtaq
//
//  Created by taimurmushtaq on 01/10/2018.
//  Copyright © 2018 Taimur Mushtaq. All rights reserved.
//

import UIKit

struct MovieDetailsModel : Codable {
    
    let statusCode: Int?
    let statusMessage: String?
    let adult : Bool?
    let backdropPath : String?
//    let belongsToCollection : String?
    let budget : Int?
    let genres : [Genre]?
    let homepage : String?
    let id : Int?
    let imdbId : String?
    let originalLanguage : String?
    let originalTitle : String?
    let overview : String?
    let popularity : Float?
    let posterPath : String?
    let productionCompanies : [ProductionCompany]?
    let productionCountries : [ProductionCountry]?
    let releaseDate : String?
    let revenue : Int?
    let runtime : Int?
    let spokenLanguages : [SpokenLanguage]?
    let status : String?
    let tagline : String?
    let title : String?
    let video : Bool?
    let voteAverage : Float?
    let voteCount : Int?
    
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
        case adult = "adult"
        case backdropPath = "backdrop_path"
//        case belongsToCollection = "belongs_to_collection"
        case budget = "budget"
        case genres = "genres"
        case homepage = "homepage"
        case id = "id"
        case imdbId = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview = "overview"
        case popularity = "popularity"
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue = "revenue"
        case runtime = "runtime"
        case spokenLanguages = "spoken_languages"
        case status = "status"
        case tagline = "tagline"
        case title = "title"
        case video = "video"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    func getPosterURL() -> String {
        return "https://image.tmdb.org/t/p/w500\(posterPath ?? "")"
    }
}


struct SpokenLanguage : Codable {
    
    let englishName : String?
    let iso6391 : String?
    let name : String?
    
    
    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso6391 = "iso_639_1"
        case name = "name"
    }
    
}


struct ProductionCountry : Codable {
    
    let iso31661 : String?
    let name : String?
    
    
    enum CodingKeys: String, CodingKey {
        case iso31661 = "iso_3166_1"
        case name = "name"
    }
    
}


struct ProductionCompany : Codable {
    
    let id : Int?
    let logoPath : String?
    let name : String?
    let originCountry : String?
    
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case logoPath = "logo_path"
        case name = "name"
        case originCountry = "origin_country"
    }
    
}


struct Genre : Codable {

    let id : Int?
    let name : String?


    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }

}
