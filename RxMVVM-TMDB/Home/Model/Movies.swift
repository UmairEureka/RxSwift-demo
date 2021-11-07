//
//  Movies.swift
//  RxMVVM-TMDB
//
//  Created by Umair  on 06/11/2021.
//

import Foundation

struct Movies :Codable {
    let listOfMovies : [Movie]?
    enum CodingKeys: String, CodingKey {
        case listOfMovies = "results"
    }
}

struct Movie: Codable {

    let genreIds: [GenreId]?
    let movieID : Int?
    let originalLanguage : String?
    let overview : String?
    let popularity : Float?
    let image : String?
    let releaseDate : String?
    let title : String?
    let video : Bool?
    let voteAverage : Float?
    let voteCount : Int?
    
    enum CodingKeys:String, CodingKey {
        case genreIds = "genre_ids"
        case movieID = "id"
        case originalLanguage = "original_language"
        case overview
        case popularity
        case image = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

extension Movie: Hashable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.movieID == rhs.movieID
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(movieID)
    }
}
