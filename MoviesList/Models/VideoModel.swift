//
//  VideoModel.swift
//  MovieList
//
//  Created by Zeeshan Tariq on 27/06/2021.
//

import Foundation

struct VideosResponseModel : Codable {
    
    let id : Int?
    let results : [VideoModel]?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case results = "results"
    }
}

struct VideoModel : Codable {
    
    let id : String?
    let iso31661 : String?
    let iso6391 : String?
    let key : String?
    let name : String?
    let site : String?
    let size : Int?
    let type : String?
    
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case iso31661 = "iso_3166_1"
        case iso6391 = "iso_639_1"
        case key = "key"
        case name = "name"
        case site = "site"
        case size = "size"
        case type = "type"
    }
    
    func getVideoURL() -> String {
        return "https://www.youtube.com/embed/\(key ?? "01")"  //watch?v=id
    }
}
