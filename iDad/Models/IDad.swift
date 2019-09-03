//
//  IDad.swift
//  App
//
//  Created by Ulysses Castillo on 9/2/19.
//

import Foundation

extension IDad {
    init(name: String, id: String, imageNames: [String], videoCodes: [String], books: [Book], quotes: [String]) {
        self.name = name
        self.id = id
        self.imageNames = imageNames
        self.videoCodes = videoCodes
        self.quotes = quotes
        self.books = Book.setIDadID(books: books, id: id)
    }
}

extension Book {
    init(title: String, imageName: String, url: String) {
        self.title = title
        self.imageName = imageName
        self.url = url
    }
    
    static func setIDadID(books: [Book], id: String) -> [Book] {
        var booksResult = [Book]()
        for var book in books {
            book.iDadID = id
            booksResult.append(book)
        }
        return booksResult
    }
}
