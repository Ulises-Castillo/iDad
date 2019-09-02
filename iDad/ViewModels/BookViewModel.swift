//
//  BookViewModel.swift
//  iDad
//
//  Created by Ulysses Castillo on 8/24/19.
//  Copyright © 2019 uly. All rights reserved.
//

import UIKit

struct BookViewModel {
    let title: String
    let coverImage: UIImage?
    let coverImageURL: URL?
    let urlString: String?
    
    init(book: Book) {
        title = book.title
        urlString = book.url
        
        coverImageURL = NetworkConstants.baseURL.appendingPathComponent(book.iDadID + "/" + book.imageName)
        coverImage = nil
    }
}
