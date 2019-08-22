//
//  IDadListViewModel.swift
//  iDad
//
//  Created by Ulysses Castillo on 8/20/19.
//  Copyright © 2019 uly. All rights reserved.
//

import UIKit

// Resposible for retrieving the data
struct IDadListViewModel {
    let iDadList: [IDadViewModel]
    
    
    init() {
        let jbp = IDadViewModel(name: "Jordan B. Peterson",
                                profilePicture: UIImage(named: "jbp")!,
                                videos: [URL(string: "wwww.JordanBPeterson.com")!],
                                quotes: ["The meaning in life is found in the adoption of resposibiilty.",
                                         "Imagine your life in 10 years if instead of avoiding what you..."],
                                books: ["Maps of Meaning", "12 Rules for Life"],
                                summary: "The most influential modern intellectial in Western society.")
        
        let dsp = IDadViewModel(name: "Dan S. Peña",
                                profilePicture: UIImage(named: "dsp")!,
                                videos: [URL(string: "wwww.JordanBPeterson.com")!],
                                quotes: ["The meaning in life is found in the adoption of resposibiilty."],
                                books: ["Maps of Meaning", "12 Rules for Life"],
                                summary: "The most influential modern intellectial in Western society.")
        
        let nutn = IDadViewModel(name: "Nuntfancy",
                                 profilePicture: UIImage(named: "nutn")!,
                                 videos: [URL(string: "wwww.JordanBPeterson.com")!],
                                 quotes: ["The meaning in life is found in the adoption of resposibiilty."],
                                 books: ["Maps of Meaning", "12 Rules for Life"],
                                 summary: "Retired U.S. AirForce Lt. Col. and creator of The Nutnfancy Project")
        
        iDadList = [jbp, dsp, nutn]
    }
}
