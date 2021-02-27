//
//  File.swift
//  
//
//  Created by Guerson Perez on 25/02/21.
//

import Foundation

/// Conform to this protocol to support overMerging.
public protocol OverMergeable: Codable {
    mutating func overMerge<T: OverMergeable>(with obj: T, idKey: String, changeKeys: Set<String>) -> T? 
}
