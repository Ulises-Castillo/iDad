//
//  IDadModel.swift
//  iDad
//
//  Created by Ulysses Castillo on 8/24/19.
//  Copyright © 2019 uly. All rights reserved.
//

import Foundation

struct IDadModel {
    let name: String
    let imageNames: [String]
    let videoCodes: [String]
    let quotes: [String]
    let books: [BookModel]
    let description: String
    let successSummary: String
    
}

struct BookModel {
    let title: String
    let coverImageName: String
    let buyUrlString: String?
}
