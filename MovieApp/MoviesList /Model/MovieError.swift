//
//  ErrorData.swift
//  MovieApp
//
//  Created by Abilkaiyr Nurzhan on 08.02.2022.
//

import Foundation

enum MovieError: Error {
    case decodingError
    case fetchingEror

    var description: String {
        switch self {
        case .fetchingEror: return  "Error happens when fetching data."
        case .decodingError: return "Error happens when decoding data."
        }
    }
}

struct ErrorData: Decodable {
    let code: String
    let message: String

    enum CodingKeys: String, CodingKey {
        case code = "status_code"
        case message = "status_message"
    }
}
