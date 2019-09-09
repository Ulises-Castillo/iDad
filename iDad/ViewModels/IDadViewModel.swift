//
//  IDadModel.swift
//  iDad
//
//  Created by Ulysses Castillo on 8/20/19.
//  Copyright © 2019 uly. All rights reserved.
//

import UIKit

@objc class IDadViewModel: NSObject {
    let name: String // Jordan B. Peterson
    private let images: [UIImage]
    private let imageURLs: [URL]
    let videoRequests: [URLRequest]
    let quotes: [String]
    let books: [BookViewModel]
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
    
    var profilePictureUrl: URL? {
        return imageUrl(index: 0)
    }
    
    var landscapePictureUrl: URL? {
        return imageUrl(index: 1)
    }
    
    func imageUrl(index: Int) -> URL? {
        guard imageURLs.count > index else {
            return nil
        }
        return imageURLs[index]
    }
    
    init(iDad: IDad) {
        name = iDad.name
        quotes = iDad.quotes
        successSummary = iDad.summary
        
        var tempBookViewModels = [BookViewModel]()
        for book in iDad.books {
            let bookViewModel = BookViewModel(book: book)
            tempBookViewModels.append(bookViewModel)
        }
        books = tempBookViewModels
        
        var tempImages = [UIImage]()
        for imageName in iDad.imageNames { //TODO: check for at least 2 images
            guard let image = UIImage(named: imageName) else {
                print("Error: could not create UIImage with imageName \(imageName)")
                continue
            }
            tempImages.append(image)
        }
        images = tempImages
        
        var tempImageURLs = [URL]()
        for imageName in iDad.imageNames { //TODO: check for at least 2 images
            let url = NetworkConstants.backendBaseUrl.appendingPathComponent(iDad.id + "/" + imageName)
            tempImageURLs.append(url)
        }
        imageURLs = tempImageURLs
        
        var tempVideoRequests = [URLRequest]()
        for videoCode in iDad.videoCodes {
            let baseURL = NetworkConstants.videoBaseUrlString
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
