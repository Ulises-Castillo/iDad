//
//  IDadModel.swift
//  iDad
//
//  Created by Ulysses Castillo on 8/20/19.
//  Copyright © 2019 uly. All rights reserved.
//

import UIKit

struct IDadViewModel {
    let name: String // Jordan B. Peterson
    var photos: [String] = []
    var videos: [String] = []
    var quotes: [String] = []
    var books: [Book] = []
    var summary: String? = nil // "The 50 Billion dollar man"
    
    // Future Params
    // let fullName: String? // for ex: Nutn = nil ("unplublicized") & Dan Peña = Daniel S. Peña
    // let wikipedia: URL

    var topQuote: String? { return quotes.first }
    var topVideo: String? { return videos.first }
    
    var profilePicture: UIImage? {
        return photo(index: 0)
    }
    
    func photo(index: Int) -> UIImage? {
        guard photos.count > index else {
            return nil
        }
        return UIImage(named: photos[index])
    }
}

struct Book {
    let title: String
    let cover: UIImage
    let url: URL?
}
