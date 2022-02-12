//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by Abilkaiyr Nurzhan on 09.02.2022.
//

import Foundation

class MovieListViewModel: MovieListViewModelProtocol {
    
    var moveDict: [MovieStatus : [Movie]] = [
        .nowPlaying: [Movie](),
        .topRated: [Movie](),
        .upcoming: [Movie](),
        .popular: [Movie]()
    ]
    
    
    var numberOfRows: Int {
        moveDict.count
    }
    
     func fetchMovies(completion: @escaping () -> Void) {
        
        MovieStatus.allCases.forEach { status in
            NetworkManager.shared.fetchMovie(by: status.rawValue) {[unowned self] result in
                switch result {
                case .success(let movies):
                    self.moveDict[status] = movies
                    completion()
                case .failure(let error):
                    // Do it with loader or alert
                    print(error.description)
                }
            }
        }
    }
    
    func cellViewModel(with status: MovieStatus) -> MovieTableViewCellViewModelProtocol? {
        guard let movies = moveDict[status] else { return nil }
        let viewModel = MovieTableViewCellViewModel(movies: movies, status: status)
        return viewModel
    }
    
}
