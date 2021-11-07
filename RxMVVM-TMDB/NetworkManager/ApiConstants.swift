//
//  ApiConstants.swift
//  RxMVVM-TMDB
//
//  Created by Umair  on 07/11/2021.
//

import Foundation

struct ApiConstants {
    static let apiKey = "46773379c4226935593ff40b31082e9e"
    static let baseUrl = URL(string: "https://api.themoviedb.org/3")!
    static let originalImageUrl = URL(string: "https://image.tmdb.org/t/p/original")!
    static let smallImageUrl = URL(string: "https://image.tmdb.org/t/p/w154")!
    
    struct Endpoints {
        static let listPopularMovies = "movie/popular"
        static let listTrendingMovies = "trending/all/day"
        static let detailMovie = "movie/"
        static let searchMovie = "search/movie"
    }
}
