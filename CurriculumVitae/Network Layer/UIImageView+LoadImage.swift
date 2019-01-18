//
//  UIImageView+LoadImage.swift
//  CurriculumVitae
//
//  Created by Suman Chatterjee on 18/01/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()
public extension UIImageView {
    
    func loadImage(url: URL, completion: @escaping () -> Void) {
        image = nil
        let urlString = url.absoluteString
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            completion()
            return
        }
        
        let session = URLSession.shared
        session.dataTask(with: url, completionHandler: { data, response, error in
            if let error = error as NSError?, error.code == -999 {
                return
            }
            DispatchQueue.main.async {
                guard let data = data else { return }
                let imageToCache = UIImage(data: data)
                imageCache.setObject(imageCache, forKey: urlString as AnyObject)
                self.image = imageToCache
                completion()
            }
        }).resume()
    }
}
