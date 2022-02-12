//
//  ImageManager.swift
//  MovieApp
//
//  Created by Abilkaiyr Nurzhan on 09.02.2022.
//

import Foundation

class ImageManager {
    static let shared = ImageManager()
    private init() {}
    
    func fetchImageData(from url: String, completion: @escaping (Data) -> Void) {
        let urlString = "\(MovieURL.baseImage)\(url)"
        guard let url = URL(string: urlString) else { return }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    completion(data)
                }
            }
        }
    }
    
}
