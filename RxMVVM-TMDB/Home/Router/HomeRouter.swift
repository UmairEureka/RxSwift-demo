//
//  HomeRouter.swift
//  RxMVVM-TMDB
//
//  Created by Umair  on 06/11/2021.
//

import Foundation
import UIKit

class HomeRouter {
    
    private var sourceView: UIViewController?
    
    var viewController : UIViewController {
        createViewController()
    }
    
    private func createViewController() -> UIViewController {
        let vc = HomeViewController(nibName: "HomeViewController", bundle: Bundle.main)
        return vc
    }
    
    func setSource(_ source: UIViewController?) {
        guard let view = source else { return }
        self.sourceView = view
    }
    
    func navigateToDetail(_ movieID:Int) {
        let detailView = DetailRouter(movieID: movieID).viewController
        sourceView?.navigationController?.pushViewController(detailView, animated: true)
    }
}
