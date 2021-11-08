//
//  HomeViewController.swift
//  RxMVVM-TMDB
//
//  Created by Umair  on 06/11/2021.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class HomeViewController : UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityView: UIView!
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = .label
        searchController.searchBar.delegate = self
        searchController.searchBar.searchTextField.accessibilityIdentifier = "HomeViewController.searchTextFieldId"
        return searchController
    }()
    
    var movies = [Movie]()
    
    var viewModel = HomeViewModel()
    var movieVM: MovieTableViewCellViewModel?
    var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Popular Movies"
        configureUI()
        loadHomeData(query: "")
    }
    
    private func configureUI(){
        tableView.registerNib(cellClass: MovieTableViewCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        
        navigationItem.searchController = self.searchController
        searchController.isActive = true
        viewModel.bind(view: self, router: HomeRouter())
    }
    
    func loadHomeData(query: String){
        viewModel.moviesList.bind(to:
                        tableView.rx.items(
                            cellIdentifier: MovieTableViewCell.nibName,
                            cellType: MovieTableViewCell.self)) { row, model, cell in
                                cell.selectionStyle = .none
                                let movieVM = MovieTableViewCellViewModel(with: model)
                                cell.bind(to: movieVM)
                            }.disposed(by: bag)
        
        tableView.rx.modelSelected(Movie.self)
            .bind { [weak self] movie in
                self?.viewModel.moveToDetail(movieID: movie.movieID ?? 0)
            }
            .disposed(by: bag)
        
        viewModel.getHomeData("")
    }
    
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        viewModel.getHomeData(searchBar.searchTextField.text ?? "")
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.getHomeData("")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchController.searchBar.resignFirstResponder()
    }
}
