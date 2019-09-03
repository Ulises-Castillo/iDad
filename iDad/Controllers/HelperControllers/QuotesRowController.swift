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
    
    var quotes = [String]() {didSet { colorArray = Utils.generateRandomColorArray(ofSize: quotes.count) }}
    
    var colorArray = [UIColor]()
    
    //MARK: CollectionView
    func cell(collectionView: UICollectionView, indexPath: IndexPath) -> QuoteCollectionViewCell {
        let nib = UINib(nibName: reusableQuoteCollectionViewCellID, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: reusableQuoteCollectionViewCellID)
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableQuoteCollectionViewCellID, for: indexPath) as? QuoteCollectionViewCell else {
            return QuoteCollectionViewCell()
        }
        
        //TODO: quote color should be handled in quoteViewModel BUT would still need to update colors in viewWillAppear or such
        let color = colorArray[indexPath.row]
        cell.backgroundColor = color
        cell.quoteLabel.backgroundColor = color
        cell.quoteLabel.text = quotes[indexPath.row] //TODO: change text color to dark when light background
        
        return cell
    }
    
    func sizeForItem(indexPath: IndexPath, viewFrame: CGSize) -> CGSize {
        return CGSize(width: viewFrame.width / 2, height: viewFrame.width / 2)
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        return section == 0 ? quotes.count : 0
    }
    
    //MARK: TableView
    func heightForRow() -> CGFloat {
        return 180
    }
}
