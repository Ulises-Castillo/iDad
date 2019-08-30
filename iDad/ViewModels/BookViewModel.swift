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
    let urlString: String?
    
    init(book: Book) {
        title = book.title
        urlString = book.url
        
        if let image = UIImage(named: book.imageName) {
            coverImage = image
        } else {
            coverImage = nil
        }
    }
    
    init(bookModel: BookModel) {
        title = bookModel.title
        urlString = bookModel.urlString
        
        if let image = UIImage(named: bookModel.coverImageName) {
            coverImage = image
        } else {
            coverImage = nil
        }
    }
}
