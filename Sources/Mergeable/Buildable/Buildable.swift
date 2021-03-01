//
//  File.swift
//  
//
//  Created by Guerson Perez on 01/03/21.
//

import Foundation

public protocol Buildable: Codable {
    func buld<T: Buildable>(type: T.Type, with changeKeys: Set<String>, idKey: String) -> T?
}
