//
//  MovieService.swift
//  MovieApp
//
//  Created by Abilkaiyr Nurzhan on 21.02.2022.
//

import Foundation
import Moya

enum MovieService {
    case fetchMovies(status: MovieStatus)
    case fetchMovieDetail(id: Int)
    case fetchImage(imageURL: String)
}

extension MovieService: TargetType {
    var baseURL: URL {
        switch self {
        case .fetchMovies, .fetchMovieDetail:
            return  URL(string: MovieURL.base)!
        case .fetchImage:
            return URL(string: MovieURL.baseImage)!
        }
    }

    var path: String {
        switch self {
        case .fetchMovies(status: let status):
            return "/movie/\(status.rawValue)"
        case .fetchMovieDetail(id: let id):
            return "/movie/\(id)"
        case .fetchImage(let url):
            return "/\(url)"
        }
    }

    var method: Moya.Method {
        .get
    }

    var task: Task {
        switch self {
        case .fetchMovies(status: _):
            return .requestParameters(parameters: ["api_key": APIkey.key,
                                                   "language": MovieLanguage.russian.rawValue],
                                      encoding: URLEncoding.queryString)
        case .fetchMovieDetail(id: _):
            return .requestParameters(parameters: ["api_key": "\(APIkey.key)",
                                                   "language": MovieLanguage.russian.rawValue,
                                                   "append_to_response": "videos,credits"],
                                      encoding: URLEncoding.queryString)
        case .fetchImage(imageURL: _):
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        ["Content-Type": "application/json"]
    }

}
