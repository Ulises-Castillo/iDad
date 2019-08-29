//
//  BackendGetIDadsRequest.swift
//  iDad
//
//  Created by Ulysses Castillo on 8/28/19.
//  Copyright © 2019 uly. All rights reserved.
//

import Foundation

typealias GetIDadsSuccessHandler = () -> Void

struct BackendGetIDadsRequest {
    
    var successHandler: GetIDadsSuccessHandler?
    var failureHandler: FailureHandler?
}

extension BackendGetIDadsRequest: BackendRequest {
    var endpoint: String {
        "iDads"
    }
    
    var method: BackendRequestMethod {
        return .get
    }
    
    var headers: [String : String]? {
        return BackendRequestHeader.acceptOctetStream
    }
    
    var data: Data? {
        return nil
    }
    
    func didSucceed(with data: Data) {
        if let iDads = try? IDadList(protobuf: data), let successHandler = successHandler {
            successHandler(iDads)
        }
    }
    
    func didFail(with error: Error) {
        if let failureHandler = failureHandler {
            failureHandler(error)
        }
    }
}
