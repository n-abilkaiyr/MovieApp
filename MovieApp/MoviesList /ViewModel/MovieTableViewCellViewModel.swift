//
//  MovieTableViewCellViewModel.swift
//  MovieApp
//
//  Created by Abilkaiyr Nurzhan on 09.02.2022.
//

import Foundation

class MovieTableViewCellViewModel: MovieTableViewCellViewModelProtocol {

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
        return MovieCollectionViewCellViewModel(movie: movie, status: status)
    }

    func viewModelForSelectedItem(selectedRow: Int) -> DetailMovieViewControllerViewModelProtocol {
        let selectedMovieId = movies[selectedRow].id
        let detailMoviewViewModel = DetailMovieViewControllerViewModel(id: selectedMovieId)
        return detailMoviewViewModel
    }

}
