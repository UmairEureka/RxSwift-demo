//
//  MovieDetailsViewController.swift
//  RxMVVM-TMDB
//
//  Created by Umair  on 07/11/2021.
//

import UIKit
import RxSwift

class MovieDetailsViewController: UIViewController {

    @IBOutlet private var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet private var contentView: UIView!
    @IBOutlet private var poster: UIImageView!
    @IBOutlet private var header: UILabel!
    @IBOutlet private var subtitle: UILabel!
    @IBOutlet private var rating: UILabel!
    @IBOutlet private var overview: UILabel!
    
    private var router = DetailRouter()
    private var viewmodel = MovieDetailViewModel()
    private var movieM :MovieDetail?
    private var bag = DisposeBag()
    
    var movieID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getMovieDetailData()
    }
    
    func getMovieDetailData(){
        
        viewmodel.movieDetail
            .subscribe(onNext: { [weak self] object in
                let detailVM = DetailViewModel(with: object)
                self?.setupViewData(movie: detailVM)
            })
            .disposed(by: bag)
        
        viewmodel.getDetailData(movieID: movieID ?? 0)
    }
    
    private func setupViewData(movie: DetailViewModel){
        DispatchQueue.main.async {
            self.header.text = movie.title
            self.poster.um_downloadImage(urlString: Constants.Url.originalImageUrl+movie.image, placeHolderImage: UIImage(named: "placeholder")!)
            self.overview.text = movie.overview
            self.subtitle.text = movie.subtitle
            self.rating.text = String(movie.rating)
            
        }
    }

}
