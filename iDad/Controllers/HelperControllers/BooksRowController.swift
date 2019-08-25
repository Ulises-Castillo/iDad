//
//  BooksRowController.swift
//  iDad
//
//  Created by Ulysses Castillo on 8/22/19.
//  Copyright © 2019 uly. All rights reserved.
//

import UIKit

class BooksRowController {
    private let reusableBookCollectionViewCellID = "BookCollectionViewCell"
    
    //MARK: CollectionView
    func cell(collectionView: UICollectionView, indexPath: IndexPath, books: [BookViewModel]) -> BookCollectionViewCell {
        let nib = UINib(nibName: reusableBookCollectionViewCellID, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: reusableBookCollectionViewCellID)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableBookCollectionViewCellID, for: indexPath) as! BookCollectionViewCell //TODO: remove !
        cell.bookCoverImageView.image = books[indexPath.row].coverImage
        
        return cell
    }
    
    func sizeForItem(indexPath: IndexPath, viewFrame: CGSize) -> CGSize {
        return CGSize(width: viewFrame.width / 2, height: viewFrame.width / 2)
    }
    
    func numberOfItemsInSection(section: Int, books: [BookViewModel]) -> Int {
        return section == 0 ? books.count : 0
    }
    
    //MARK: TableView
    func heightForRow() -> CGFloat {
        return 180
    }
}
