//
//  MovieDetailViewModel.swift
//  RxMVVM-TMDB
//
//  Created by Umair  on 07/11/2021.
//

import Foundation
import RxSwift
import RxCocoa

class MovieDetailViewModel {
    
    private var apiServices = ApiServices()
    private var router: DetailRouter?
    var movieDetail = PublishSubject<MovieDetail>()
    var bag = DisposeBag()
    
    func bind(view: MovieDetailsViewController, router: DetailRouter){
        self.router = router
    }
    
    func getDetailData(movieID: Int) {
        return apiServices.getMovieDetail(movieID)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] object in
                self.movieDetail.onNext(object)
                self.movieDetail.onCompleted()
            })
            .disposed(by: bag)
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
        self.overview = model.overview ?? ""
        self.popularity = model.popularity ?? 0.0
        self.image = model.image ?? ""
        self.releaseDate = model.releaseDate ?? ""
        self.title = model.title ?? ""
        self.rating = String(format: "%.2f", model.voteAverage ?? 0.0)
        self.voteCount = model.voteCount ?? 0
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
