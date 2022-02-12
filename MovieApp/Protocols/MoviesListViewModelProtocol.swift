//
//  MoviesListViewModelProtocol.swift
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
