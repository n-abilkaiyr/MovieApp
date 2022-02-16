//
//  DetailMovieViewControllerViewModel.swift
//  MovieApp
//
//  Created by Abilkaiyr Nurzhan on 15.02.2022.
//

import Foundation

final class DetailMovieViewControllerViewModel: DetailMovieViewControllerViewModelProtocol {
    
    private let movieId: Int
    private var movie: Movie!
    
    init(id: Int) {
        movieId = id
    }
    
    var rating: String {
        movie.ratingText
    }
    
    func fetchMovie(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchMovie(with: movieId, and: Movie.self) { result in
            switch result {
            case .success(let movie):
                self.movie = movie
                completion()
            case .failure(let error):
                print(error.description)
            }
        }
    }
    
    
    
}
