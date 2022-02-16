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
    
    
    func fetchMovie<T, M: Decodable>(with endpoint: T, and type: M.Type, completion: @escaping (Result<M, MovieError>) -> Void) {
        let urlString = "\(MovieURL.base)/movie/\(endpoint)?api_key=\(APIkey.key)&language=\(MovieLanguage.russian.rawValue)&append_to_response=videos,credits"
        
        guard let url = URL(string: urlString) else { return }
        
        
        // Do it with MOYA
        URLSession.shared.dataTask(with: url) { data, _, error  in
            if error != nil {
                let movieError = MovieError.fetchingEror
                completion(.failure(movieError))
            }
            
            if let data = data,
               let decodedData = self.parseJSON(from: data, to: M.self) {
                    DispatchQueue.main.async {
                        completion(.success(decodedData))
                    }
            } else {
                let movieError = MovieError.decodingError
                DispatchQueue.main.async {
                    completion(.failure(movieError))
                }
            }
        }.resume()
    }
    
    
    private func parseJSON<T: Decodable>(from data: Data, to: T.Type) -> T? {
        do {
            let movieResponseData = try JSONDecoder().decode(T.self, from: data)
            return movieResponseData
        } catch {
            return nil
        }
    }
}
