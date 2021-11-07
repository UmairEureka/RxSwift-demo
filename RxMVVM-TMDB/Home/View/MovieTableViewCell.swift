//
//  MovieTableViewCell.swift
//  RxMVVM-TMDB
//
//  Created by Umair  on 07/11/2021.
//

import UIKit

class MovieTableViewCell: UITableViewCell, ReusableView, NibProvidable {

    @IBOutlet private var title: UILabel!
    @IBOutlet private var subtitle: UILabel!
    @IBOutlet private var rating: UILabel!
    @IBOutlet private var poster: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        cancelImageLoading()
    }
    
    func bind(to viewModel:MovieTableViewCellViewModel){
        cancelImageLoading()
        self.title.text = viewModel.title
        self.subtitle.text = viewModel.subtitle
        self.rating.text = viewModel.rating
        self.poster.um_downloadImage(urlString: Constants.URL.urlImages+viewModel.image, placeHolderImage: UIImage(named: "placeholder")!)
    }
    
    private func cancelImageLoading() {
        poster.image = nil
    }
    
}
