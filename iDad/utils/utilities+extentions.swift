//
//  utilities.swift
//  iDad
//
//  Created by Ulysses Castillo on 8/20/19.
//  Copyright © 2019 uly. All rights reserved.
//

import UIKit

struct Utils {
    // for nested collectionView testing
    static func generateRandomColor2DArray() -> [[UIColor]] {
        let numberOfRows = 20
        let numberOfItemsPerRow = 15
        
        return (0..<numberOfRows).map { _ in
            return (0..<numberOfItemsPerRow).map { _ in UIColor.randomColor() }
        }
    }
    
    static func generateRandomColorArray(ofSize size: Int) -> [UIColor] {
        return (0..<size).map { _ in
            return UIColor.randomColor() }
    }
}

extension UIColor {
    class func randomColor() -> UIColor {
        func randomFloat() -> CGFloat {
            return CGFloat(arc4random() % 100) / 100
        }
        return UIColor(hue: randomFloat(), saturation: randomFloat(), brightness: randomFloat(), alpha: 1.0)
    }
}

extension String {
    func surroundedWithQuotes() -> String {
        return "\"\(self)\""
    }
    func prefixedWithLongHyphen() -> String {
        return "– \(self)"
    }
}

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    public func imageFromURL(_ url: URL) {
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        activityIndicator.startAnimating()
        
        // check cache for image
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            self.image = cachedImage
            return
        }
        
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
                // cache image
                imageCache.setObject(image, forKey: url.absoluteString as NSString)

                activityIndicator.removeFromSuperview()
                self.image = image
            }
        }.resume()
    }
}
