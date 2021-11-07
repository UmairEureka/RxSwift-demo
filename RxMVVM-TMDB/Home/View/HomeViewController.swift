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
    }
    
    func loadHomeData(query: String){
//        self.activityView.isHidden = false
        viewModel.moviesList.bind(to:
                        tableView.rx.items(
                            cellIdentifier: MovieTableViewCell.nibName,
                            cellType: MovieTableViewCell.self)) { row, model, cell in
                                cell.selectionStyle = .none
                                let movieM = self.movies[row]
                                let movieVM = MovieTableViewCellViewModel(with: movieM)
                                cell.bind(to: movieVM)
                            }.disposed(by: bag)
        
        
        
//        viewModel.getHomeData(query, completion: { movies in
//            DispatchQueue.main.async { [unowned self] in
//                self.activityView.isHidden = true
//                self.movies = movies
//                viewModel.bind(view: self, router: HomeRouter())
//                self.tableView.reloadData()
//            }
//        })
    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.movies.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        //let cell = self.tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as! MovieTableViewCell
//        let cell = self.tableView.dequeueReusableCell(withClass: MovieTableViewCell.self)!
//        cell.selectionStyle = .none
//        let movieM = self.movies[indexPath.row]
//        let movieVM = MovieTableViewCellViewModel(with: movieM)
//        cell.bind(to: movieVM)
//        return cell
//
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let movieId = self.movies[indexPath.row].movieID ?? 0
//        viewModel.moveToDetail(movieID: movieId)
//    }
    
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        loadHomeData(query: searchText)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        loadHomeData(query: searchBar.searchTextField.text ?? "")
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        loadHomeData(query: "")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchController.searchBar.resignFirstResponder()
    }
}
