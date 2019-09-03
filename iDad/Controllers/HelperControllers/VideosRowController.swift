//
//  VideosRowController.swift
//  iDad
//
//  Created by Ulysses Castillo on 8/24/19.
//  Copyright © 2019 uly. All rights reserved.
//

import UIKit
import WebKit

//TODO: use classes and have a base (default) class
class VideosRowController: NSObject, WKNavigationDelegate {
    private let reusableVideoCollectionViewCellID = "VideoCollectionViewCell"
    
    var videoRequests = [URLRequest]()
    
    private var urlCellHash = [String: VideoCollectionViewCell]()
    
    //MARK: CollectionView
    func cell(collectionView: UICollectionView, indexPath: IndexPath) -> VideoCollectionViewCell {
        
        let nib = UINib(nibName: reusableVideoCollectionViewCellID, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: reusableVideoCollectionViewCellID)
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableVideoCollectionViewCellID, for: indexPath) as? VideoCollectionViewCell else {
            return VideoCollectionViewCell()
        }
        
        let videoRequest = videoRequests[indexPath.row]
        guard let urlString = videoRequest.url?.absoluteString else { return cell }
        
        // should only load videoRequest once OR if a cell is being reused
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
    
    func numberOfItemsInSection(section: Int) -> Int {
        return section == 0 ? videoRequests.count : 0
    }
    
    //MARK: TableView
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
        
        // slight delay to prevent white flash (FOUC)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            cell.webView.isHidden = false
        })
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("Webview \(String(describing: webView.url)) didFinish navigation \(navigation.debugDescription)")
    }
}
