//
//  HomeViewModel.swift
//  RxMVVM-TMDB
//
//  Created by Umair  on 06/11/2021.
//

import Foundation

class HomeViewModel {
    
    private var router: HomeRouter?
    private var apiServices = ApiServices()
    
    func getHomeData(_ query: String, completion: @escaping ([Movie])->()) {
        apiServices.getMovies(query, completion: completion)
    }
    
    func bind(view: HomeViewController, router: HomeRouter){
        self.router = router
        self.router?.setSource(view)
    }
    
    func moveToDetail(movieID: Int) {
        router?.navigateToDetail(movieID)
    }
    
}
