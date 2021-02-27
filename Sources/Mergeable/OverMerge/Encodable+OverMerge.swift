//
//  File.swift
//  
//
//  Created by Guerson Perez on 27/02/21.
//

import Foundation

public extension OverMergeable {
    /**
     Merges the current object with object received, changing only the keys received.
     - Parameters:
        - obj: object to be merged into self.
        - idKey:
        - changeKeys: Keys indicating which values should be merged.
     - returns: An object containing ONLY the values that were modied.
     */
    mutating func overMerge<T: OverMergeable>(with obj: T, idKey: String, changeKeys: Set<String>) -> T? {
        var selfDict = self.toDictionary()
        let objDict = obj.toDictionary()
        let changesDict = selfDict.overMerge(with: objDict, idKey: idKey, keys: changeKeys)
        let objType = T.self
        if let updated = selfDict.toModel(objType) as? Self {
            self = updated
        }
        return changesDict?.toModel(objType)
    }
}
