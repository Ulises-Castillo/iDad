//
//  NetworkConfig.swift
//  iDad
//
//  Created by Ulysses Castillo on 9/2/19.
//  Copyright © 2019 uly. All rights reserved.
//

import Foundation

let USE_NETWORK_DATA = true // Network or local mock data

struct NetworkConstants {
    static let ENVIRONMENT: Environment = .prod
    
    static let productionUrlString = "https://idad.vapor.cloud" // prod URL
    static let devUrlString = "https://idad-dev.vapor.cloud"    // dev URL
    static let localHostUrlString = "http://localhost:8080"     // local testing URL
    
    static var backendBaseUrl: URL {
        var url: String
        switch ENVIRONMENT {
        case .prod:
            url = productionUrlString
        case .dev:
            url = devUrlString
        case .localHost:
            url = localHostUrlString
        }
        return URL(string: url)!
    }
    
    static let videoBaseUrlString = "https://www.youtube.com/embed/"
    
    enum Environment {
        case prod
        case dev
        case localHost
    }
}
