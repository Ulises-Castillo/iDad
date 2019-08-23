//
//  VideoCollectionViewCell.swift
//  iDad
//
//  Created by Ulysses Castillo on 8/21/19.
//  Copyright © 2019 uly. All rights reserved.
//

import UIKit
import WebKit

//TODO: consider implementing WKNavigationDelegate here and using another delegate ? // maybe just make videoRow into a class
class VideoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var webView: WKWebView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
