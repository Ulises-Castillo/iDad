//
//  QuotesRowController.swift
//  iDad
//
//  Created by Ulysses Castillo on 8/24/19.
//  Copyright © 2019 uly. All rights reserved.
//

import UIKit

class QuotesRowController {
    private let reusableQuoteCollectionViewCellID = "QuoteCollectionViewCell"
    
    //MARK: CollectionView
    func cell(collectionView: UICollectionView, indexPath: IndexPath, quotes: [String]) -> QuoteCollectionViewCell {
        let nib = UINib(nibName: reusableQuoteCollectionViewCellID, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: reusableQuoteCollectionViewCellID)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableQuoteCollectionViewCellID, for: indexPath) as! QuoteCollectionViewCell //TODO: remove !
        
        let color = UIColor.randomColor() //TODO: if you want consistent colors generate array per row and hold in memory
        cell.backgroundColor = color
        cell.quoteLabel.backgroundColor = color
        cell.quoteLabel.text = quotes[indexPath.row]
        
        return cell
    }
    
    func sizeForItem(indexPath: IndexPath, viewFrame: CGSize) -> CGSize {
        return CGSize(width: viewFrame.width / 2, height: viewFrame.width / 2)
    }
    
    func numberOfItemsInSection(section: Int, quotes: [String]) -> Int {
        return section == 0 ? quotes.count : 0
    }
    
    //MARK: TableView
    func heightForRow() -> CGFloat {
        return 180
    }
}
