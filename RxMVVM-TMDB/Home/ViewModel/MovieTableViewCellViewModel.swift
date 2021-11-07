//
//  MovieViewModel.swift
//  RxMVVM-TMDB
//
//  Created by Umair  on 07/11/2021.
//

import Foundation

struct MovieTableViewCellViewModel {
    
    let genreIds : [GenreId]?
    let movieID : Int
    let overview : String
    let popularity : Float
    let image : String
    let releaseDate : String?
    let title : String
    let rating : String
    let voteCount : Int
    
    init(with model: Movie) {
        self.genreIds = model.genreIds ?? []
        self.movieID = model.movieID ?? 0
        self.overview = model.overview ?? ""
        self.popularity = model.popularity ?? 0.0
        self.image = model.image ?? ""
        self.releaseDate = model.releaseDate ?? ""
        self.title = model.title ?? ""
        self.rating = String(format: "%.2f", model.voteAverage ?? 0.0)
        self.voteCount = model.voteCount ?? 0
    }
    
}

extension MovieTableViewCellViewModel {
    var genreNames: [String] {
        if let genreIds = genreIds {
            return genreIds.map { $0.description }
        }
        return []
    }
    var subtitle: String {
        let genresDescription = genreNames.joined(separator: ", ")
        return "\(releaseYear) | \(genresDescription)"
    }
    var releaseYear: Int {
        let date = releaseDate.flatMap { MovieTableViewCellViewModel.dateFormatter.date(from: $0) } ?? Date()
        return Calendar.current.component(.year, from: date)
    }

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}

