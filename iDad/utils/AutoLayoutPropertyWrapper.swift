//
//  AutoLayoutPropertyWrapper.swift
//  iDad
//
//  Created by Ulysses Castillo on 10/19/21.
//  Copyright © 2021 uly. All rights reserved.
//

import UIKit

@propertyWrapper
public struct UsesAutoLayout<T: UIView> {
    public var wrappedValue: T {
        didSet {
            wrappedValue.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        wrappedValue.translatesAutoresizingMaskIntoConstraints = false
    }
}
