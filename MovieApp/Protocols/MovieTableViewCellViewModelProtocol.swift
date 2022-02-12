//
//  MoviesTableViewCellViewModelProtocol.swift
//  MovieApp
//
//  Created by Abilkaiyr Nurzhan on 09.02.2022.
//

import Foundation

protocol MoviesTableViewCellViewModelProtocol {
    var status: MovieStatus { get set }
    var statusName: String { get }
    init(movies: [Movie])
}
