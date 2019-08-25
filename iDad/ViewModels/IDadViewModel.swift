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
    private let images: [UIImage]
    let videoRequests: [URLRequest]
    let quotes: [String]
    let books: [BookViewModel]
    let description: String
    let successSummary: String // "The 50 Billion dollar man" story
    
    // Future Params
    // let fullName: String? // for ex: Nutn = nil ("unplublicized") & Dan Peña = Daniel S. Peña
    // let wikipedia: URL

    var topQuote: String? { return quotes.first }
//    var topVideo: String? { return videos.first }
    
    var profilePicture: UIImage? {
        return image(index: 0)
    }
    var landscapePicture: UIImage? {
        return image(index: 1)
    }
    
    func image(index: Int) -> UIImage? {
        guard images.count > index else {
            return nil
        }
        return images[index]
    }
    
    init(iDadModel: IDadModel) {
        name = iDadModel.name
        quotes = iDadModel.quotes
        description = iDadModel.description
        successSummary = iDadModel.successSummary
        
        var tempBookViewModels = [BookViewModel]()
        for bookModel in iDadModel.books {
            let bookViewModel = BookViewModel(bookModel: bookModel)
            tempBookViewModels.append(bookViewModel)
        }
        books = tempBookViewModels
        
        var tempImages = [UIImage]()
        for imageName in iDadModel.imageNames { //TODO: check for at least 2 images
            guard let image = UIImage(named: imageName) else {
                print("Error: could not create UIImage with imageName \(imageName)")
                continue
            }
            tempImages.append(image)
        }
        images = tempImages
        
        var tempVideoRequests = [URLRequest]()
        for videoCode in iDadModel.videoCodes {
            let baseURL = "https://www.youtube.com/embed/"
            guard let videoURL = URL(string: baseURL + videoCode) else {
                print("Error: could not create URL with videoCode \(videoCode)")
                continue
            }
            let videoRequest = URLRequest(url: videoURL)
            tempVideoRequests.append(videoRequest)
        }
        videoRequests = tempVideoRequests
    }
}
