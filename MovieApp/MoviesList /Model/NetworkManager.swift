//
//  NetworkManager.swift
//  MovieApp
//
//  Created by Abilkaiyr Nurzhan on 08.02.2022.
//

import Foundation
class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    
    func fetchMovie(by status: String, completion: @escaping (Result<[Movie], MovieError>) -> Void) {
        let urlString = "\(MovieURL.movie)/\(status)?api_key=\(APIkey.key)&language=\(MovieLanguage.russian.rawValue)"
        
        guard let url = URL(string: urlString) else { return }
        
        // Do it with MOYA
        URLSession.shared.dataTask(with: url) { data, _, error  in

            if error != nil {
                let movieError = MovieError.fetchingEror
                completion(.failure(movieError))
            }
            
            if let data = data,
               let movieResponseData = self.parseJSON(from: data) {
                let movies = movieResponseData.results
                DispatchQueue.main.async {
                    completion(.success(movies))
                }
                
            } else {
                let movieError = MovieError.decodingError
                DispatchQueue.main.async {
                    completion(.failure(movieError))
                }
                
            }
        }.resume()
    }
    
    
    func parseJSON(from data: Data) -> MovieResponseData? {
        do {
            let movieResponseData = try JSONDecoder().decode(MovieResponseData.self, from: data)
            return movieResponseData
        } catch {
            return nil
        }
    }
}
