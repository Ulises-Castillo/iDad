//
//  NetworkConfig.swift
//  iDad
//
//  Created by Ulysses Castillo on 9/2/19.
//  Copyright © 2019 uly. All rights reserved.
//

import Foundation

let USE_LOCAL_DATA = true // local mock data for testing

struct NetworkConstants {
    static let ENVIRONMENT: Environment = .test
    
    static let productionUrlString = "https://www.iDad.com" // prod URL
    static let testUrlString = "http://localhost:8080"      // local testing URL
    
    static var baseURL: URL {
        var url: String
        switch ENVIRONMENT {
        case .prod:
            url = productionUrlString
        case .test:
            url = testUrlString
        }
        return URL(string: url)!
    }
    
    enum Environment {
        case prod
        case test
    }
}
