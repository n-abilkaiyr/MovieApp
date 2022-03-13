//
//  NetworkManager.swift
//  MovieApp
//
//  Created by Abilkaiyr Nurzhan on 08.02.2022.
//

import Foundation
import Moya
class NetworkManager {

    static let shared = NetworkManager()
    private let movieProvider = MoyaProvider<MovieService>()
    private init() {}

    func fetchMovies(by status: MovieStatus, completion: @escaping ([Movie]) -> Void) {
        movieProvider.request(.fetchMovies(status: status)) { result in
            switch result {
            case .success(let response):
                guard let movieResponse =  self.parseJSON(from: response.data, to: MovieResponseData.self) else { return }
                completion(movieResponse.results)

            case .failure(let moyaError):
                print(moyaError.localizedDescription)
            }
        }
    }

    func fetchMovie(by id: Int, completion: @escaping (Movie) -> Void) {
        movieProvider.request(.fetchMovieDetail(id: id)) { [unowned self] result in
            switch result {
            case .success(let response):
                guard let movie = self.parseJSON(from: response.data, to: Movie.self) else { return }
                completion(movie)
            case .failure(let moyaError):
                print(moyaError.localizedDescription)
            }
        }
    }

    private func parseJSON<T: Decodable>(from data: Data, to type: T.Type) -> T? {
        do {
            let movieResponseData = try JSONDecoder().decode(T.self, from: data)
            return movieResponseData
        } catch {
            print("Error in decoding data")
            return nil
        }
    }

}
