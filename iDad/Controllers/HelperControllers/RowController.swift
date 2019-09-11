//
//  RowControllers.swift
//  iDad
//
//  Created by Ulysses Castillo on 9/10/19.
//  Copyright © 2019 uly. All rights reserved.
//

import UIKit

protocol RowController {
    func cell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
    
    func sizeForItem(indexPath: IndexPath, viewFrame: CGSize) -> CGSize
    
    func numberOfItemsInSection(section: Int) -> Int
    
    func heightForRow() -> CGFloat
}
