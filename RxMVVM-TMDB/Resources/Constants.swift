//
//  Constants.swift
//  RxMVVM-TMDB
//
//  Created by Umair  on 06/11/2021.
//

import Foundation

struct Constants {
    
    static let api_key = "?api_key=46773379c4226935593ff40b31082e9e"
    static let apiKey = "46773379c4226935593ff40b31082e9e"
    static let language = "?language=en"
    static let query = "&query="
    
    struct Url {
        static let baseUrl = "https://api.themoviedb.org/3/"
        
        static let originalImageUrl = "https://image.tmdb.org/t/p/original"
        static let smallImageUrl = "https://image.tmdb.org/t/p/w200"
    }
    
    struct Endpoints {
        static let urlListPopularMovies = "movie/popular"
        static let urlListTrendingMovies = "trending/all/day"
        static let urlDetailMovie = "movie/"
        static let urlSearchMovie = "search/movie"
    }
    
    static let popularListUrl = Constants.Url.baseUrl+Constants.Endpoints.urlListPopularMovies
    static let trendingListUrl = Constants.Url.baseUrl+Constants.Endpoints.urlListTrendingMovies
    static let movieDetailUrl = Constants.Url.baseUrl+Constants.Endpoints.urlDetailMovie
    static let movieSearchUrl = Constants.Url.baseUrl+Constants.Endpoints.urlSearchMovie+Constants.language
    
}
