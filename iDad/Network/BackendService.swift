//
//  BackendService.swift
//  iDad
//
//  Created by Ulysses Castillo on 8/28/19.
//  Copyright © 2019 uly. All rights reserved.
//

import Foundation

class BackendService {
    static let sharedInstance = BackendService()
    
    let baseUrl = URL(string: "http://localhost:8080")! // local testing url
    let session = URLSession.shared
    let backendQueue = DispatchQueue(label: "IDad.Backend.Request.Queue") // Serial Queue - FIFO
    
    func execute(backendRequest: BackendRequest) {
        
        backendQueue.async(qos: .userInteractive, flags: []) { [weak self] () -> Void in
            guard let strongSelf = self else {
                print("Error executing backend request (1)")
                return
            }
            
            var urlRequest = URLRequest(url: strongSelf.baseUrl.appendingPathComponent(backendRequest.endpoint), cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 10.0)
            
            urlRequest.httpMethod = backendRequest.method.rawValue
            
            if let data = backendRequest.data {
                urlRequest.httpBody = data
            }
            
            if let headers = backendRequest.headers {
                for (key, value) in headers {
                    urlRequest.addValue(value, forHTTPHeaderField: key)
                }
            }
            
            let task = strongSelf.session.dataTask(with: urlRequest) { (data, resposnse, error) in
                guard let data = data, let _ = resposnse, error == nil else {
                    if let error = error {
                        print("IDad Backend | Backend Request | \(backendRequest.method) | \(backendRequest.endpoint) | FAIL | Error: \(error.localizedDescription)")
                        backendRequest.didFail(with: error)
                    }
                    return
                }
                print("IDad Backend | Backend Request | \(backendRequest.method) | \(backendRequest.endpoint) | SUCCESS")
                backendRequest.didSucceed(with: data)
            }
            task.resume()
        }
    }
}

