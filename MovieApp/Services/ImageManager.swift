//
//  ImageManager.swift
//  MovieApp
//
//  Created by Abilkaiyr Nurzhan on 09.02.2022.
//

import Foundation
import Moya
class ImageManager {
    static let shared = ImageManager()
    
    private let imageCache = NSCache<NSString, NSData>()
    private let movieProvider = MoyaProvider<movieService>()
    
    private init() {}
    
    func fetchImageData(from url: String, completion: @escaping (Data) -> Void) {
        
        if let cachedImage = imageCache.object(forKey: NSString(string: url)) {
            completion(cachedImage as Data)
        } else {
            movieProvider.request(.fetchImage(imageURL: url)) { [unowned self] result in
                switch result {
                case .success(let response):
                    let imageData = response.data
                    completion(imageData)
                    self.imageCache.setObject(imageData as NSData, forKey: url as NSString)
                case .failure(let moyaError):
                    print(moyaError.localizedDescription)
                }
            }
        }
    }
    
}
