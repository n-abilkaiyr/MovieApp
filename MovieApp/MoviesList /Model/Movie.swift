//
//  MovieStatus.swift
//  MovieApp
//
//  Created by Abilkaiyr Nurzhan on 08.02.2022.
//

import Foundation

enum MovieStatus: String, CaseIterable {
    case nowPlaying = "now_playing"
    case topRated = "top_rated"
    case upcoming
    case popular
    
    var description: String {
        switch self {
        case .nowPlaying: return "В Показе"
        case .topRated: return "Toп рейтинга"
        case .upcoming: return "Скоро"
        case .popular: return "Популярные"
        }
    }
    
    var position: Int {
        switch self {
        case .nowPlaying: return 0 
        case .topRated: return 1
        case .upcoming: return 2
        case .popular: return 3
        }
    }
    
    static func getStatus(by row: Int) -> MovieStatus {
        switch row {
        case 0: return .nowPlaying
        case 1: return .topRated
        case 2: return .upcoming
        default: return .popular
        }
    }
}

enum MovieLanguage: String {
    case russian = "ru"
    case english = "en"
    case german = "de"
}

struct MovieResponseData: Decodable {
    let results: [Movie]
}

struct Movie: Decodable {
    let name: String
    let posterImage: String?
    let backDropImage: String?
    
    
    enum CodingKeys: String, CodingKey {
        case posterImage = "poster_path"
        case name = "title"
        case backDropImage = "backdrop_path"
    }
}
