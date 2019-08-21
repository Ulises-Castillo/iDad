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
