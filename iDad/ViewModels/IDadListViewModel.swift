//
//  IDadListViewModel.swift
//  iDad
//
//  Created by Ulysses Castillo on 8/20/19.
//  Copyright © 2019 uly. All rights reserved.
//

import UIKit

// Resposible for retrieving the data, constructing, and managing the list
@objc class IDadListViewModel: NSObject {
    @objc dynamic var iDadList: [IDadViewModel]?
    
    init(iDadModels: [IDadModel]) {
        var tempIDadViewModels = [IDadViewModel]()
        for iDadModel in iDadModels {
            let iDadViewModel = IDadViewModel(iDadModel: iDadModel)
            tempIDadViewModels.append(iDadViewModel)
        }
        iDadList = tempIDadViewModels
    }
    
    // update from generated protobuf type
    func updateIDadList(iDadList: IDadList) {
        var tempIDadViewModels = [IDadViewModel]()
        for iDadModel in iDadList.list {
            let iDadViewModel = IDadViewModel(iDad: iDadModel)
            tempIDadViewModels.append(iDadViewModel)
        }
        self.iDadList = tempIDadViewModels
    }
    
    override init() {
        super.init()
        // Download iDad data from Backend
        var request = BackendGetIDadsRequest()
        
        request.successHandler = { iDads in
            DispatchQueue.main.async {
                self.updateIDadList(iDadList: iDads)
            }
        }
        
        request.failureHandler = { error in
            print(error)
        }
        
        request.execute()
    }
    
    convenience init(useMockData: Bool = true) {
        //if useMockData {
        let mockDataModels = IDadListViewModel.generateMockData()
        
        self.init(iDadModels: mockDataModels)
    }
    
    static func generateMockData() -> [IDadModel] {
        let jbp = IDadModel(name: "Jordan Peterson",
                            imageNames: ["jbp", "jbp3"],
                            videoCodes: ["wLvd_ZbX1w0","-5RCmu-HuTg", "5ER1LOarlgg", "s1tS7ylRVHw", "4OmC6LyO5QI"],
                            quotes: ["The meaning in life is found in the adoption of resposibiilty.",
                                     "Imagine your life in 10 years if instead of avoiding the things you know you should do you actually did them every single day–that's powerful.",
                                     "The purpose of life is finding the largest burden that you can bear and bearing it.",
                                     "If you fulfill your obligations everyday you don't need to worry about the future.",
                                     "It took untold generations to get you where you are. A little gratitude might be in order. If you're going to insist on bending the world to your way, you better have your reasons.",
                                     "RULE 4 COMPARE YOURSELF TO WHO YOU WERE YESTERDAY, NOT TO WHO SOMEONE ELSE IS TODAY",
                                     "To suffer terribly and to know yourself as the cause: that is Hell."],
                            books: [BookModel(title: "12 Rules For Life", coverImageName: "12rules", urlString: "https://www.amazon.com/12-Rules-Life-Antidote-Chaos/dp/0345816021"),
                                    BookModel(title: "Maps of Meaning", coverImageName: "mom", urlString: "https://www.amazon.com/Maps-Meaning-Architecture-Jordan-Peterson/dp/0415922216/ref=sr_1_3?keywords=maps+of+meaning&qid=1566760997&s=books&sr=1-3")],
                            description: "",
                            successSummary: "")
        
        let dsp = IDadModel(name: "Dan Peña",
                            imageNames: ["dsp", "dspQuote"],
                            videoCodes: ["YwmO_aZRmqE", "ZYk18h1o5T0", "_jtRTa826qk", "5Qt64XLtMJE"],
                            quotes: ["Tough times don’t last – tough people do!",
                                     "Don’t waste time on things you can’t change!",
                                     "Show me your friends and I’ll show you your future.",
                                     "Once you become fearless, life becomes limitless.",
                                     "Man's greatest burden is unfufilled potential."],
                            books: [BookModel(title: "Your First 100 Million", coverImageName: "first100", urlString: "https://archive.org/details/DanS.PeaYourFirst100Million2ndEd/page/n13")],
                            description: "",
                            successSummary: "")
        
        let spj = IDadModel(name: "Steve Jobs",
                            imageNames: ["spj", "spj3"],
                            videoCodes: ["UF8uR6Z6KLc", "ppXQMsj6Yfo", "gFE-Tdz24hM"],
                            quotes: ["The people who are crazy enough to think they can change the world are the ones who do.",
                                     "Have the courage to follow your heart and intuition. They somehow know what you truly want to become.",
                                     "I'm convinced that about half of what separates successful entrepreneurs from the non-successful ones is pure perseverance.",
                                     "My favorite things in life don't cost any money. It's really clear that the most precious resource we all have is time."],
                            books: [BookModel(title: "Steve Jobs, By Walter Issacson", coverImageName: "issacson", urlString: "https://www.amazon.com/Steve-Jobs-Walter-Isaacson/dp/1451648537")],
                            description: "",
                            successSummary: "")
        
        return [jbp, dsp, spj]
    }
}
