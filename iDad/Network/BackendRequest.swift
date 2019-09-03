//
//  BackendRequest.swift
//  iDad
//
//  Created by Ulysses Castillo on 8/28/19.
//  Copyright © 2019 uly. All rights reserved.
//

import Foundation

typealias SuccessHandler = () -> Void
typealias FailureHandler = (Error) -> Void

enum BackendRequestMethod: String {
    case get, post, put, delete
}

struct BackendRequestHeader {
    
    static let contentTypeOctetStream = ["Content-Type": "application/octet-stream"]
    static let acceptOctetStream = ["Accept": "application/octet-stream"]
}

protocol BackendRequest {
    
    var endpoint: String { get }
    var method: BackendRequestMethod { get }
    var headers: [String: String]? { get }
    var data: Data? { get }
    func didSucceed(with data: Data)
    func didFail(with error: Error)
    func execute()
}

// default implementation of protocol function execute()
extension BackendRequest {
    
    func execute() {
        BackendService.sharedInstance.execute(backendRequest: self)
    }
}
