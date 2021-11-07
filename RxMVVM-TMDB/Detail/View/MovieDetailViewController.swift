//
//  MovieDetailsViewController.swift
//  RxMVVM-TMDB
//
//  Created by Umair  on 07/11/2021.
//

import UIKit

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
    
    var movieID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getMovieDetailData()
    }
    
    func getMovieDetailData(){
        viewmodel.getDetailData(movieID: movieID ?? 0) { [weak self] movieM in
            self?.movieM = movieM
            let detailVM = DetailViewModel(with: movieM)
            self?.setupViewData(movie: detailVM)
        }
    }
    
    private func setupViewData(movie: DetailViewModel){
        DispatchQueue.main.async {
            self.header.text = movie.title
            self.poster.um_downloadImage(urlString: Constants.URL.urlImages+movie.image, placeHolderImage: UIImage(named: "placeholder")!)
            self.overview.text = movie.overview
            self.subtitle.text = movie.subtitle
            self.rating.text = String(movie.rating)
            
        }
    }

}
