//
//  MovieDetailViewModel.swift
//  RxMVVM-TMDB
//
//  Created by Umair  on 07/11/2021.
//

import Foundation

class MovieDetailViewModel {
    
    private var apiServices = ApiServices()
    private var router: DetailRouter?
    
    func bind(view: MovieDetailsViewController, router: DetailRouter){
        self.router = router
    }
    
    func getDetailData(movieID: Int, completion: @escaping (MovieDetail)->()){
        return apiServices.getMovieDetail(movieID, completion: completion)
    }
    
}

class DetailViewModel {
    
    let genreIds : [Genre]?
    let movieID : Int
    let overview : String
    let popularity : Float
    let image : String
    let releaseDate : String?
    let title : String
    let rating : String
    let voteCount : Int
    
    init(with model: MovieDetail) {
        self.genreIds = model.genres
        self.movieID = model.id
        self.overview = model.overview
        self.popularity = model.popularity
        self.image = model.image
        self.releaseDate = model.releaseDate
        self.title = model.title
        self.rating = String(format: "%.2f", model.voteAverage)
        self.voteCount = model.voteCount
    }
    
    var genreNames: [String] {
        if let genre = genreIds {
            return genre.map { $0.name }
        }
        return []
    }
    var subtitle: String {
        let genresDescription = genreNames.joined(separator: ", ")
        return "\(releaseYear) | \(genresDescription)"
    }
    var releaseYear: Int {
        let date = releaseDate.flatMap { DetailViewModel.dateFormatter.date(from: $0) } ?? Date()
        return Calendar.current.component(.year, from: date)
    }

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
