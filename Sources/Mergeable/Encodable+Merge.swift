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
    /// - Returns: Object containing only updated fields.
    mutating func merge<T: Mergeable>(_ type: T.Type, with obj: T) -> T?  {
        var selfDict = self.toDictionary()
        let objDict = obj.toDictionary()
        let changesDict = selfDict.merge(with: objDict)

        if let updated = selfDict.toModel(type) as? Self {
            self = updated
        }
        
        return changesDict?.toModel(type)
    }
}
