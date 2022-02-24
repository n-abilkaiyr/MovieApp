//
//  MovieCollectionViewCellViewModel.swift
//  MovieApp
//
//  Created by Abilkaiyr Nurzhan on 09.02.2022.
//

import Foundation

class MovieCollectionViewCellViewModel: MovieCollectionViewCellViewModelProtocol {

    var status: MovieStatus
    private let movie: Movie

    init(movie: Movie, status: MovieStatus) {
        self.movie = movie
        self.status = status
    }

    func fetchImageData(completeion: @escaping (Data) -> Void) {
        let imageUrl = status == .nowPlaying ? movie.posterImage : movie.backDropImage
        guard let url = imageUrl else { return }
         ImageManager.shared.fetchImageData(from: url) { data in
            completeion(data)
        }
    }

    var movieName: String {
        return movie.name
    }

}
