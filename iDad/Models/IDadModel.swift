//
//  IDadModel.swift
//  iDad
//
//  Created by Ulysses Castillo on 8/24/19.
//  Copyright © 2019 uly. All rights reserved.
//

import Foundation

//TODO: Add `fullName` property (ex. "Jordan Peterson" -> "Jordan B. Peterson")
struct IDadModel { //TODO: unify w/ protobuf model, so that one model can be used for local and network testing // need to get initializer for protobuf models
    let name: String
    let imageNames: [String]
    let videoCodes: [String]
    let quotes: [String]
    let books: [BookModel]
    let description: String
    let successSummary: String
}
