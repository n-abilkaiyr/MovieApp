//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by Abilkaiyr Nurzhan on 09.02.2022.
//

import Foundation

protocol MovieListViewModelProtocol {
    var navigation: MovieListNavigation? { get set }
    var moveDict: [MovieStatus: [Movie]] { get set}
    var numberOfRows: Int { get }
    func fetchMovies (completion: @escaping () -> Void)
    func cellViewModel(with status: MovieStatus) -> MovieTableViewCellViewModelProtocol?
}

final class MovieListViewModel: MovieListViewModelProtocol {
    
    var navigation: MovieListNavigation?
    
    var moveDict: [MovieStatus: [Movie]] = [.nowPlaying: [],
                                            .topRated: [],
                                            .upcoming: [],
                                            .popular: [] ]
    
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
        let viewModel = MovieTableViewCellViewModel(movies: movies,
                                                    status: status)
        
        viewModel.navigaiton = navigation as? MovieDetailNavigaiton
        return viewModel
    }
}
