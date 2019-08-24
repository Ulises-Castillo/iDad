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
                                photos: ["jbp", "jbp3"],
                                videos: ["wLvd_ZbX1w0","-5RCmu-HuTg", "5ER1LOarlgg", "s1tS7ylRVHw", "4OmC6LyO5QI"],
                                quotes: ["The meaning in life is found in the adoption of resposibiilty.",
                                         "Imagine your life in 10 years if instead of avoiding the things you know you should do you actually did them every single day–that's powerful.",
                                         "The purpose of life is finding the largest burden that you can bear and bearing it.",
                                         "If you fulfill your obligations everyday you don't need to worry about the future.",
                                         "It took untold generations to get you where you are. A little gratitude might be in order. If you're going to insist on bending the world to your way, you better have your reasons.",
                                         "RULE 4 COMPARE YOURSELF TO WHO YOU WERE YESTERDAY, NOT TO WHO SOMEONE ELSE IS TODAY",
                                         "To suffer terribly and to know yourself as the cause: that is Hell."],
                                books: [Book(title: "12 Rules For Life", cover: UIImage(named: "12rules")!, url: nil),
                                        Book(title: "Maps of Meaning", cover: UIImage(named: "mom")!, url: nil)],
                                summary: "The most influential modern intellectial in Western society.")
        
        let dsp = IDadViewModel(name: "Dan S. Peña",
                                photos: ["dsp", "dspQuote"],
                                videos: ["YwmO_aZRmqE", "ZYk18h1o5T0", "_jtRTa826qk", "5Qt64XLtMJE"],
                                quotes: ["Tough times don’t last – tough people do!",
                                         "Don’t waste time on things you can’t change!",
                                         "Show me your friends and I’ll show you your future.",
                                         "Once you become fearless, life becomes limitless.",
                                         "Man's greatest burden is unfufilled potential."],
                                books: [Book(title: "Your First 100 Million", cover: UIImage(named: "first100")!, url: nil)],
                                summary: "The 50 Billion dollar man.")
        
        let spj = IDadViewModel(name: "Steven P. Jobs",
                                 photos: ["spj", "spj3"],
                                 videos: ["UF8uR6Z6KLc", "ppXQMsj6Yfo", "gFE-Tdz24hM"],
                                 quotes: ["The people who are crazy enough to think they can change the world are the ones who do.",
                                          "Have the courage to follow your heart and intuition. They somehow know what you truly want to become.",
                                          "I'm convinced that about half of what separates successful entrepreneurs from the non-successful ones is pure perseverance.",
                                          "My favorite things in life don't cost any money. It's really clear that the most precious resource we all have is time."],
                                 books: [Book(title: "Steve Jobs, By Walter Issacson", cover: UIImage(named: "issacson")!, url: nil)],
                                 summary: "Retired U.S. AirForce Lt. Col. and creator of The Nutnfancy Project")
        
        iDadList = [jbp, dsp, spj]
    }
}
