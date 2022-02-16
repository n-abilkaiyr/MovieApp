//
//  ImageManager.swift
//  MovieApp
//
//  Created by Abilkaiyr Nurzhan on 09.02.2022.
//

import Foundation

class ImageManager {
    let imageCache = NSCache<NSString, NSData>()
    static let shared = ImageManager()
    private init() {}
    
    func fetchImageData(from url: String, completion: @escaping (Data) -> Void) {
        let urlString = "\(MovieURL.baseImage)\(url)"
        guard let url = URL(string: urlString) else { return }
        
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
            completion(cachedImage as Data)
        } else {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.imageCache.setObject(data as NSData, forKey: urlString as NSString)
                        completion(data)
                    }
                }
            }
        }
        
        
    }
    
}
