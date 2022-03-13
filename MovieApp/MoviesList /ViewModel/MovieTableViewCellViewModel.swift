//
//  MovieTableViewCellViewModel.swift
//  MovieApp
//
//  Created by Abilkaiyr Nurzhan on 09.02.2022.
//

import Foundation
protocol MovieTableViewCellViewModelProtocol {
    var navigaiton: MovieDetailNavigaiton? { get set }
    var movies: [Movie] { get set }
    var status: MovieStatus! { get }
    var statusName: String { get }
    
    init(movies: [Movie], status: MovieStatus)
    
    func collectionCellViewModel(for indexPath: IndexPath) -> MovieCollectionViewCellViewModelProtocol?
    func viewModelForSelectedItem(selectedRow: Int) -> DetailMovieViewControllerViewModelProtocol
    func goToDetailPage(for movieIndex: Int)
}

class MovieTableViewCellViewModel: MovieTableViewCellViewModelProtocol {
    var navigaiton: MovieDetailNavigaiton?
    var movies = [Movie]()
    var status: MovieStatus!

    var statusName: String {
        status.description
    }

    required init(movies: [Movie], status: MovieStatus) {
        self.movies = movies
        self.status = status
    }

    func collectionCellViewModel(for indexPath: IndexPath) -> MovieCollectionViewCellViewModelProtocol? {
        let movie = movies[indexPath.row]
        return MovieCollectionViewCellViewModel(movie: movie,
                                                status: status)
    }

    func viewModelForSelectedItem(selectedRow: Int) -> DetailMovieViewControllerViewModelProtocol {
        let selectedMovieId = movies[selectedRow].id
        let detailMoviewViewModel = DetailMovieViewControllerViewModel(id: selectedMovieId)
        return detailMoviewViewModel
    }
    
    func goToDetailPage(for movieIndex: Int) {
        guard let navigation = navigaiton else { return }
        let detailViewModel = viewModelForSelectedItem(selectedRow: movieIndex)
        navigation.goToDetailPage(with: detailViewModel)
    }
}
