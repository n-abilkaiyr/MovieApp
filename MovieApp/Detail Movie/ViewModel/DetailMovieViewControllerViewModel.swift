//
//  DetailMovieViewControllerViewModel.swift
//  MovieApp
//
//  Created by Abilkaiyr Nurzhan on 15.02.2022.
//

import Foundation

protocol DetailMovieViewControllerViewModelProtocol {
    var genreText: String { get }
    var yearText: String { get }
    var durationText: String { get }
    var ratingText: String { get }
    var scoreText: String { get }
    var overViewText: String { get }
    func fetchMovie(completion: @escaping () -> Void)
    func fetchImageData(completion: @escaping (Data) -> Void)
}

final class DetailMovieViewControllerViewModel: DetailMovieViewControllerViewModelProtocol {

    private let movieId: Int
    private var movie: Movie!
    
    init(id: Int) {
        movieId = id
    }
    
    var genreText: String {
        
        "\(movie.genres?.first?.name ?? "n/a") *"
    }
    var yearText: String {
        movie.releaseData?.split(separator: "-").map {String($0)}.first ?? "n/a"
    }
    
    var durationText: String {
        guard let runtime = movie.runtime else { return "n/a" }
        let hours = runtime / 60
        let minutes = runtime % 60
        let text = "\(hours) \(hours > 1 ? "часа" : "час"), \(minutes) мин."
        return text
    }
    
    var overViewText: String {
        movie.overview
    }
    
    var ratingText: String {
        let rating = Int(movie.voteAverage)
        let ratingText = (0..<rating).reduce("") { result, _ in
            result + "⭐️"
        }
        return ratingText
    }
    
    var scoreText: String {
        guard ratingText.count > 0 else { return "n/a" }
        return "\(ratingText.count)/10"
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
    
    func fetchImageData(completion: @escaping (Data) -> Void) {
        guard let imageURL = movie.backDropImage else { return }
        ImageManager.shared.fetchImageData(from: imageURL) { data in
            completion(data)
        }
    }
    
   
}
