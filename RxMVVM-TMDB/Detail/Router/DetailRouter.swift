//
//  DetailRouter.swift
//  RxMVVM-TMDB
//
//  Created by Umair  on 07/11/2021.
//

import Foundation
import UIKit

class DetailRouter {
    
    var viewController: UIViewController{
        return createViewController()
    }
    
    var movieID: Int
    private var sourceView:UIViewController?
    
    
    init(movieID: Int? = 0){
        self.movieID = movieID ?? 0
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else { return }
        self.sourceView = view
    }
    
    private func createViewController()-> UIViewController {
        let view = MovieDetailsViewController(nibName: "MovieDetailsViewController", bundle: Bundle.main)
        view.movieID = self.movieID
        return view
    }
}
