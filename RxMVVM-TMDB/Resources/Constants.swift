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
    
    struct URL {
        static let baseUrl = "https://api.themoviedb.org/3/"
        static let urlImages = "https://image.tmdb.org/t/p/w200"
    }
    
    struct Endpoints {
        static let urlListPopularMovies = "movie/popular"
        static let urlListTrendingMovies = "trending/all/day"
        static let urlDetailMovie = "movie/"
        static let urlSearchMovie = "search/movie"
    }
    
    static let popularListUrl = Constants.URL.baseUrl+Constants.Endpoints.urlListPopularMovies
    static let trendingListUrl = Constants.URL.baseUrl+Constants.Endpoints.urlListTrendingMovies
    static let movieDetailUrl = Constants.URL.baseUrl+Constants.Endpoints.urlDetailMovie
    static let movieSearchUrl = Constants.URL.baseUrl+Constants.Endpoints.urlSearchMovie+Constants.language
    
}
