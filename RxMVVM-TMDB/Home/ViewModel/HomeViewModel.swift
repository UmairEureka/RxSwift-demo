//
//  HomeViewModel.swift
//  RxMVVM-TMDB
//
//  Created by Umair  on 06/11/2021.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel {
    
    private var router: HomeRouter?
    private var apiServices = ApiServices()
    var moviesList = PublishSubject<[Movie]>()
    let bag = DisposeBag()
    
    func getHomeData(_ query: String) {
        apiServices.getMovies(query)
            .subscribe(onNext: { [unowned self] movies in
                self.moviesList.onNext(movies)
                self.moviesList.onCompleted()
            })
            .disposed(by: bag)
    }
    
    func bind(view: HomeViewController, router: HomeRouter){
        self.router = router
        self.router?.setSource(view)
    }
    
    func moveToDetail(movieID: Int) {
        router?.navigateToDetail(movieID)
    }
    
}
