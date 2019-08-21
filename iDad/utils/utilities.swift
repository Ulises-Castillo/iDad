//
//  utilities.swift
//  iDad
//
//  Created by Ulysses Castillo on 8/20/19.
//  Copyright © 2019 uly. All rights reserved.
//

import Foundation

extension String {
    func surroundedWithQuotes() -> String {
        return "\"\(self)\""
    }
    func prefixedWithLongHyphen() -> String {
        return "– \(self)"
    }
}
