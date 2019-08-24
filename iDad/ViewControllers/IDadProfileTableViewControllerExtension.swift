//
//  IDadProfileTableViewControllerExtension.swift
//  iDad
//
//  Created by Ulysses Castillo on 8/22/19.
//  Copyright © 2019 uly. All rights reserved.
//

import UIKit
import WebKit

//TODO: use classes and have a base (default) class
class VideosRow: NSObject, WKNavigationDelegate {
    private let reusableVideoCollectionViewCellID = "VideoCollectionViewCell"
    
    private var urlCellHash = [String: VideoCollectionViewCell]()
    
    //MARK: CollectionView
    func cell(collectionView: UICollectionView, indexPath: IndexPath, videoRequests: [URLRequest]) -> VideoCollectionViewCell {
        
        let nib = UINib(nibName: reusableVideoCollectionViewCellID, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: reusableVideoCollectionViewCellID)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableVideoCollectionViewCellID, for: indexPath) as! VideoCollectionViewCell //TODO: remove !
        
        let videoRequest = videoRequests[indexPath.row]
        guard let urlString = videoRequest.url?.absoluteString else { return cell }
        
        // should only load videoRequest once OR if a cell is being reused //TODO: test with huge list of videos
        if cell.webView.url?.absoluteString != urlString {
            cell.webView.navigationDelegate = self
            cell.webView.load(videoRequest)
        }
        // save reference to cell
        urlCellHash[urlString] = cell

        return cell
    }
    
    func sizeForItem(indexPath: IndexPath, viewFrame: CGSize) -> CGSize {
        return CGSize(width: viewFrame.width / 1.5, height: viewFrame.width / 1.5)
    }
    
    func numberOfItemsInSection(section: Int, videos: [URLRequest]) -> Int {
        return section == 0 ? videos.count : 0
    }
    
    //MARK: tableView
    func heightForRow() -> CGFloat {
        return 210
    }
    
    //MARK: WKNavigationDelegate
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("Webview \(String(describing: webView.url)) didCommit navigation \(navigation.debugDescription)")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Webview \(String(describing: webView.url)) didFinish navigation \(navigation.debugDescription)")
        
        guard let url = webView.url?.absoluteString,
            let cell = urlCellHash[url] else {
            return
        }
        cell.activityIndicator.isHidden = true
        
        // delay to prevent white flash
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            cell.webView.isHidden = false
        })
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("Webview \(String(describing: webView.url)) didFinish navigation \(navigation.debugDescription)")
    }
}

extension IDadProfileTableViewController { //TODO: most of this can probably be done directly in the VC
    struct QuotesRow { //TODO: "QuotesCollectionView" might be better name, though tableView data is also being set hmmm
        static private let reusableQuoteCollectionViewCellID = "QuoteCollectionViewCell"
        
        static func cell(collectionView: UICollectionView, indexPath: IndexPath, quotes: [String]) -> QuoteCollectionViewCell {
            let nib = UINib(nibName: reusableQuoteCollectionViewCellID, bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: reusableQuoteCollectionViewCellID)
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableQuoteCollectionViewCellID, for: indexPath) as! QuoteCollectionViewCell //TODO: remove !
            
            let color = UIColor.randomColor() //TODO: if you want consistent colors generate array per row and hold in memory
            cell.backgroundColor = color
            cell.quoteLabel.backgroundColor = color
            cell.quoteLabel.text = quotes[indexPath.row]
            
            return cell
        }
        
        static func sizeForItem(indexPath: IndexPath, viewFrame: CGSize) -> CGSize {
            return CGSize(width: viewFrame.width / 2, height: viewFrame.width / 2)
        }
        
        static func numberOfItemsInSection(section: Int, quotes: [String]) -> Int {
            return section == 0 ? quotes.count : 0
        }
        
        static func heightForRow() -> CGFloat {
            return 180
        }
    }
    
    struct BooksRow { //TODO: "QuotesCollectionView" might be better name, though tableView data is also being set hmmm
        static private let reusableBookCollectionViewCellID = "BookCollectionViewCell"
        
        static func cell(collectionView: UICollectionView, indexPath: IndexPath, books: [BookViewModel]) -> BookCollectionViewCell {
            let nib = UINib(nibName: reusableBookCollectionViewCellID, bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: reusableBookCollectionViewCellID)
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableBookCollectionViewCellID, for: indexPath) as! BookCollectionViewCell //TODO: remove !            
            cell.bookCoverImageView.image = books[indexPath.row].coverImage
            
            return cell
        }
        
        static func sizeForItem(indexPath: IndexPath, viewFrame: CGSize) -> CGSize {
            return CGSize(width: viewFrame.width / 2, height: viewFrame.width / 2)
        }
        
        static func numberOfItemsInSection(section: Int, books: [BookViewModel]) -> Int {
            return section == 0 ? books.count : 0
        }
        
        static func heightForRow() -> CGFloat {
            return 180
        }
    }
}
