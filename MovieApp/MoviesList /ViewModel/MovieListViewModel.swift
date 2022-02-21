//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by Abilkaiyr Nurzhan on 09.02.2022.
//

import Foundation

protocol MovieListViewModelProtocol {
    var moveDict: [MovieStatus : [Movie]] { get set}
    func fetchMovies (completion: @escaping () -> Void)
    var numberOfRows: Int { get }
    func cellViewModel(with status: MovieStatus) -> MovieTableViewCellViewModelProtocol?
}

final class MovieListViewModel: MovieListViewModelProtocol {
   

    var moveDict: [MovieStatus : [Movie]] = [
        .nowPlaying: [],
        .topRated: [],
        .upcoming: [],
        .popular: []
    ]
    
    var numberOfRows: Int {
        moveDict.count
    }
    
     func fetchMovies(completion: @escaping () -> Void) {
        MovieStatus.allCases.forEach { status in
            
            NetworkManager.shared.fetchMovies(by: status) { [unowned self ] movies in
                self.moveDict[status] = movies
                completion()
            }
        }
    }
    
    func cellViewModel(with status: MovieStatus) -> MovieTableViewCellViewModelProtocol? {
        guard let movies = moveDict[status] else { return nil }
        let viewModel = MovieTableViewCellViewModel(movies: movies, status: status)
        return viewModel
    }
    
}
