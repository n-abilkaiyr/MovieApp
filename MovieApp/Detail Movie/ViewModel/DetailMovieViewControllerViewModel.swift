//
//  DetailMovieViewControllerViewModel.swift
//  MovieApp
//
//  Created by Abilkaiyr Nurzhan on 15.02.2022.
//

import Foundation

protocol DetailMovieViewControllerViewModelProtocol {
    var navigation: TrailerNavigation? { get set }
    var genreText: String { get }
    var yearText: String { get }
    var durationText: String { get }
    var ratingText: String { get }
    var scoreText: String { get }
    var overViewText: String { get }
    var crew: [String] { get }
    var directors: [String] { get }
    var producers: [String] { get }
    var writers: [String] { get }
    var youtubeURLs: [URL] { get }
    var trailerNames: [String] { get }
    var movieName: String { get }
    func fetchMovie(completion: @escaping () -> Void)
    func fetchImageData(completion: @escaping (Data) -> Void)
    func openYoutubeViedo(by url: URL)
}

final class DetailMovieViewControllerViewModel: DetailMovieViewControllerViewModelProtocol {
    var navigation: TrailerNavigation?

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
        guard !ratingText.isEmpty else { return "n/a" }
        return "\(ratingText.count)/10"
    }

    var crew: [String] {
        guard let credits = movie.credits else { return ["n/a"] }
        let actors = credits.cast.map { $0.name }
        return actors.count > 10 ? Array(actors.prefix(upTo: 10)) : actors
    }
    var directors: [String] {
        guard let credits = movie.credits else { return ["n/a"] }
        let directors = credits.crew.filter { $0.job == "Director"}.map {$0.name}
        return directors.isEmpty ? ["n/a"] : directors
    }

    var producers: [String] {
        guard let credits = movie.credits else { return ["n/a"] }
        let producers = credits.crew.filter { $0.job == "Producer"}.map {$0.name}
        return producers.isEmpty ? ["n/a"]  : producers
    }

    var writers: [String] {
        guard let credits = movie.credits else { return ["n/a"] }
        let writers = credits.crew.filter { $0.job == "Writer"}.map {$0.name}
        return writers.isEmpty ? ["n/a"] : writers
    }
  
    var youtubeURLs: [URL] {
        var urls: [URL] = []
        guard let videos = movie.videos?.results else { return urls }
        urls = videos.filter {$0.site == "YouTube"}.map {URL(string: "https://youtube.com/watch?v=\($0.key)")!}
        return urls
    }

    var trailerNames: [String] {
        guard let videos = movie.videos?.results else { return [] }
        return videos.map { $0.name }
    }

    var movieName: String {
        movie.name
    }

    func fetchMovie(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchMovie(by: movieId) { [unowned self] movie in
            self.movie = movie
            completion()
        }
    }

    func fetchImageData(completion: @escaping (Data) -> Void) {
        guard let imageURL = movie.backDropImage else { return }
        ImageManager.shared.fetchImageData(from: imageURL) { data in
            completion(data)
        }
    }
    
    func openYoutubeViedo(by url: URL) {
        guard let navigation = navigation else { return }
        navigation.openYoutubeVideo(by: url)
    }

}
