//
//  File.swift
//  
//
//  Created by Ita on 7/6/20.
//

import Foundation

/// Objects that need to support merging
public protocol Mergeable: Codable {
    mutating func merge<T: Mergeable>(_ type: T.Type, with obj: T) -> T?
}
