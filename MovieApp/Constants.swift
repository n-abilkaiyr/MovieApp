//
//  Constants.swift
//  MovieApp
//
//  Created by Abilkaiyr Nurzhan on 08.02.2022.
//

import UIKit


struct APIkey {
    static let key = "ae7bab04e1ae64802a49d922b9effcc1"
}

struct MovieURL {
    static let base = "https://api.themoviedb.org/3"
    static let movie = "https://api.themoviedb.org/3/movie"
    static let baseImage = "https://image.tmdb.org/t/p/w500"
}

struct Font {
    static let movieStausFont = UIFont.systemFont(ofSize: 25, weight: .bold)
    static let movieNameFont = UIFont.systemFont(ofSize: 15, weight: .medium)
}

struct Color {
    static let movieStausColor = UIColor.black
    static let backgroundColor = UIColor.systemBackground
}
