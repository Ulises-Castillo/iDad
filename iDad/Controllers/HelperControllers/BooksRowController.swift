//
//  BooksRowController.swift
//  iDad
//
//  Created by Ulysses Castillo on 8/22/19.
//  Copyright © 2019 uly. All rights reserved.
//

import UIKit

class BooksRowController: RowController {
    private let reusableBookCollectionViewCellID = "BookCollectionViewCell"
    
    var books = [BookViewModel]()
    
    //MARK: CollectionView
    func cell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let nib = UINib(nibName: reusableBookCollectionViewCellID, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: reusableBookCollectionViewCellID)
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableBookCollectionViewCellID, for: indexPath) as? BookCollectionViewCell else {
            return BookCollectionViewCell()
        }
        
        if !USE_NETWORK_DATA {
            cell.bookCoverImageView.image =  books[indexPath.row].coverImage
        } else if let url = books[indexPath.row].coverImageURL {
            cell.bookCoverImageView.imageFromURL(url)
        }
        
        return cell
    }
    
    func sizeForItem(indexPath: IndexPath, viewFrame: CGSize) -> CGSize {
        return CGSize(width: viewFrame.width / 2, height: viewFrame.width / 2)
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        return section == 0 ? books.count : 0
    }
    
    func didSelectItemAt(indexPath: IndexPath) {
        guard let urlString = books[indexPath.row].urlString,
            let url = URL(string: urlString) else { return }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    //MARK: TableView
    func heightForRow() -> CGFloat {
        return 180
    }
}
