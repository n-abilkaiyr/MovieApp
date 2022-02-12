//
//  MovieCollectionViewCellProtocol.swift
//  MovieApp
//
//  Created by Abilkaiyr Nurzhan on 09.02.2022.
//

import Foundation


protocol MovieCollectionViewCellViewModelProtocol {
    var movieName: String { get }
    var status: MovieStatus { get }
    func fetchImageData(completeion: @escaping (Data) -> Void)
}
