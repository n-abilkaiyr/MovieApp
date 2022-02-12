//
//  MoviesTableViewCellViewModelProtocol.swift
//  MovieApp
//
//  Created by Abilkaiyr Nurzhan on 09.02.2022.
//

import Foundation

protocol MovieTableViewCellViewModelProtocol {
    var movies: [Movie] { get set }
    var status: MovieStatus! { get }
    var statusName: String { get }
    init(movies: [Movie], status: MovieStatus)
    func collectionCellViewModel(for indexPath: IndexPath) -> MovieCollectionViewCellViewModelProtocol?
}
