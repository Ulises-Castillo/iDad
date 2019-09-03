//
//  IDadList.swift
//  App
//
//  Created by Ulysses Castillo on 9/2/19.
//

import Foundation

extension IDadList {
    init(iDads: [IDad]) {
        self.list = iDads
    }
    
    static func mockData() -> IDadList {
        return IDadList(iDads: [
            IDad(
                name: "Jordan Peterson",
                id: "jbp",
                imageNames: [
                    "jbp.jpg",
                    "jbp3.jpg",
                ],
                videoCodes: [
                    "wLvd_ZbX1w0",
                    "-5RCmu-HuTg",
                    "5ER1LOarlgg",
                    "s1tS7ylRVHw",
                    "4OmC6LyO5QI",
                ],
                books: [
                    Book(title: "12 Rules For Life", imageName: "12rules.jpg", url: "https://www.amazon.com/12-Rules-Life-Antidote-Chaos/dp/0345816021"),
                    Book(title: "Maps of Meaning", imageName: "mom.jpg", url: "https://www.amazon.com/Maps-Meaning-Architecture-Jordan-Peterson/dp/0415922216/ref=sr_1_3?keywords=maps+of+meaning&qid=1566760997&s=books&sr=1-3"),
                ],
                quotes: [
                    "The meaning in life is found in the adoption of resposibiilty.",
                    "Imagine your life in 10 years if instead of avoiding the things you know you should do you actually did them every single day–that's powerful.",
                    "The purpose of life is finding the largest burden that you can bear and bearing it.",
                    "If you fulfill your obligations everyday you don't need to worry about the future.",
                    "It took untold generations to get you where you are. A little gratitude might be in order. If you're going to insist on bending the world to your way, you better have your reasons.",
                    "RULE 4 COMPARE YOURSELF TO WHO YOU WERE YESTERDAY, NOT TO WHO SOMEONE ELSE IS TODAY",
                    "To suffer terribly and to know yourself as the cause: that is Hell.",
                ]
            ),
            
            IDad(
                name: "Dan Peña",
                id: "dsp",
                imageNames: [
                    "dsp.jpeg",
                    "dspQuote.png",
                ],
                videoCodes: [
                    "YwmO_aZRmqE",
                    "ZYk18h1o5T0",
                    "_jtRTa826qk",
                    "5Qt64XLtMJE",
                ],
                books: [
                    Book(title: "Your First 100 Million", imageName: "first100.jpeg", url: "https://archive.org/details/DanS.PeaYourFirst100Million2ndEd/page/n13"),
                ],
                quotes: [
                    "Tough times don’t last – tough people do!",
                    "Don’t waste time on things you can’t change!",
                    "Show me your friends and I’ll show you your future.",
                    "Once you become fearless, life becomes limitless.",
                    "Man's greatest burden is unfufilled potential.",
                ]
            ),
            
            IDad(
                name: "Steve Jobs",
                id: "spj",
                imageNames: [
                    "spj.png",
                    "spj3.jpg",
                ],
                videoCodes: [
                    "UF8uR6Z6KLc",
                    "ppXQMsj6Yfo",
                    "gFE-Tdz24hM",
                ],
                books: [
                    Book(title: "Steve Jobs, By Walter Issacson", imageName: "issacson.jpg", url: "https://www.amazon.com/Steve-Jobs-Walter-Isaacson/dp/1451648537"),
                ],
                quotes: [
                    "The people who are crazy enough to think they can change the world are the ones who do.",
                    "Have the courage to follow your heart and intuition. They somehow know what you truly want to become.",
                    "I'm convinced that about half of what separates successful entrepreneurs from the non-successful ones is pure perseverance.",
                    "My favorite things in life don't cost any money. It's really clear that the most precious resource we all have is time.",
                ]
            ),
        ])
    }
}
