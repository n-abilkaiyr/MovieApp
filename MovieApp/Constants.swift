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
    static let baseImage = "https://image.tmdb.org/t/p/w500"
}

struct Font {
    static let bold25 = UIFont.systemFont(ofSize: 25, weight: .bold)
    static let medium15 = UIFont.systemFont(ofSize: 15, weight: .medium)
    static let regular15 = UIFont.systemFont(ofSize: 15, weight: .regular)
}

struct Color {
    static let black = UIColor.black
    static let backgroundColor = UIColor.systemBackground
}

struct Title {
    static let main = "Фильмы"
}

struct LayoutGuide {
    static let left: CGFloat = 16
    static let right: CGFloat = 16
    static let top: CGFloat = 20
    static let bottom: CGFloat = 20
    static let zero: CGFloat = 0
}
