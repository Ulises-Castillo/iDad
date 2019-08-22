//
//  IDadProfileTableViewControllerExtension.swift
//  iDad
//
//  Created by Ulysses Castillo on 8/22/19.
//  Copyright © 2019 uly. All rights reserved.
//

import UIKit

extension IDadProfileTableViewController { //TODO: most of this can probably be done directly in the VC
    struct VideosRow {
        static private let reusableVideoCollectionViewCellID = "VideoCollectionViewCell"
        
        static func cell(collectionView: UICollectionView, indexPath: IndexPath) -> VideoCollectionViewCell {
            let nib = UINib(nibName: reusableVideoCollectionViewCellID, bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: reusableVideoCollectionViewCellID)
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableVideoCollectionViewCellID, for: indexPath) as! VideoCollectionViewCell //TODO: remove !
            
            let videoURL = URL(string: "https://www.youtube.com/embed/5ER1LOarlgg")! //TODO: remove !
            let requestObj = URLRequest(url: videoURL)
            cell.webView.load(requestObj)
            
            return cell
        }
        
        static func sizeForItem(indexPath: IndexPath, viewFrame: CGSize) -> CGSize {
            return CGSize(width: viewFrame.width / 3, height: viewFrame.width / 3)
        }
        
        static func numberOfItemsInSection(section: Int) -> Int {
            return section == 0 ? 3 : 0
        }
        
        static func heightForRow() -> CGFloat {
            return 160
        }
    }

    struct QuotesRow { //TODO: "QuotesCollectionView" might be better name, though tableView data is also being set hmmm
        static private let reusableQuoteCollectionViewCellID = "QuoteCollectionViewCell"
        
        static func cell(collectionView: UICollectionView, indexPath: IndexPath, quotes: [String]) -> QuoteCollectionViewCell {
            let nib = UINib(nibName: reusableQuoteCollectionViewCellID, bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: reusableQuoteCollectionViewCellID)
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableQuoteCollectionViewCellID, for: indexPath) as! QuoteCollectionViewCell //TODO: remove !
            
            cell.quoteLabel.text = quotes[indexPath.row].surroundedWithQuotes() //TODO: why is quotes optional ?
            
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
}
