//
//  IDadImageView.swift
//  iDad
//
//  Created by Ulysses Castillo on 9/13/19.
//  Copyright © 2019 uly. All rights reserved.
//

import UIKit

class IDadImageView: UIImageView {
    static let imageCache = NSCache<NSString, UIImage>()
    
    var imageUrlString: String?
    
    public func imageFromURL(_ url: URL) {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        activityIndicator.startAnimating()
        
        // check cache for image
        if let cachedImage = IDadImageView.imageCache.object(forKey: url.absoluteString as NSString) {
            self.image = cachedImage
            return
        }
        imageUrlString = url.absoluteString
        
        if self.image == nil {
            self.addSubview(activityIndicator)
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: no image data")
                return
            }
            DispatchQueue.main.async {
                guard let image = UIImage(data: data) else {
                    print("Error: unable to create image from data")
                    return
                }
                // prevent wrong image being set on imageView
                // happens on slow network responses when imageView
                // is reused within tableView/collectionView cell
                if self.imageUrlString == url.absoluteString {
                    self.image = image
                    activityIndicator.removeFromSuperview()
                }
                // cache image
                IDadImageView.imageCache.setObject(image, forKey: url.absoluteString as NSString)
            }
        }.resume()
    }
}
