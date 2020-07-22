//
//  File.swift
//  
//
//  Created by Ita on 7/6/20.
//

import Foundation

/// Conform to this protocol to support Merging.
public protocol Mergeable: Codable {
    mutating func merge<T: Mergeable>(with obj: T, idKey: String) -> T?
}
