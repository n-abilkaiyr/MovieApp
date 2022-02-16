//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by Abilkaiyr Nurzhan on 09.02.2022.
//

import Foundation

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
            NetworkManager.shared.fetchMovie(with: status.rawValue, and: MovieResponseData.self) {[unowned self] result in
                switch result {
                case .success(let moviesResponse):
                    self.moveDict[status] = moviesResponse.results
                    completion()
                case .failure(let error):
                    // Do it with loader or alert later
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
