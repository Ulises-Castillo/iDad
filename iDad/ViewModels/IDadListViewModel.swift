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
   
    convenience init(localData: Bool = false) {
        if USE_NETWORK_DATA {
            self.init()
        } else {
            self.init(iDadModels: IDadList.mockData())
        }
    }
    
    // init using backend data
    private override init() {
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
    
    // init from local data
    private init(iDadModels: IDadList) {
        super.init()
        
        var tempIDadViewModels = [IDadViewModel]()
        for iDadModel in iDadModels.list {
            let iDadViewModel = IDadViewModel(iDad: iDadModel)
            tempIDadViewModels.append(iDadViewModel)
        }
        self.iDadList = tempIDadViewModels
    }
    
    private func updateIDadList(iDadList: IDadList) { //TODO: unify dup logic, if possible
        var tempIDadViewModels = [IDadViewModel]()
        for iDadModel in iDadList.list {
            let iDadViewModel = IDadViewModel(iDad: iDadModel)
            tempIDadViewModels.append(iDadViewModel)
        }
        self.iDadList = tempIDadViewModels
    }
}
