//
//  File.swift
//  
//
//  Created by Ita on 7/6/20.
//

import Foundation
import CodableUtils

public extension Mergeable {
    /// Merge two objects conforming to Mergeable protocol.
    /// - Parameters:
    ///     - type: Object type.
    ///     - obj: Object to merge into self.
    ///     - idKey: If nested objects use an id field pass in the name of the variable and this function will merge objects together with equal ids.
    /// - Returns: Object containing only updated fields.
    mutating func merge<T: Mergeable>(with obj: T, idKey: String = defaultIdKey) -> T?  {
        var selfDict = self.toDictionary()
        let objDict = obj.toDictionary()
        let changesDict = selfDict.merge(with: objDict, idKey: idKey)
        let objType = T.self
        if let updated = selfDict.toModel(objType) as? Self {
            self = updated
        }
        return changesDict?.toModel(objType)
    }
    
}
