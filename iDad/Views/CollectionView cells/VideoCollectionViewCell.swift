//
//  VideoCollectionViewCell.swift
//  iDad
//
//  Created by Ulysses Castillo on 8/21/19.
//  Copyright © 2019 uly. All rights reserved.
//

import UIKit
import WebKit

class VideoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var webView: WKWebView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
