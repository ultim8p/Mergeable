//
//  File.swift
//  
//
//  Created by Guerson Perez on 25/02/21.
//

import Foundation

public extension Dictionary {
    /**
     Merges current dictionary with new dictionary updating the keys passed.
     - Parameters:
        - dict: The new dictionary to be merged.
        - idKey: Name of id fields inside the dictionaries.
        - keys: Keys that should be updated in the current dictionary using the values in the new dict.
     - returns: A dictionary containing only the changes.
     - note: Both dictionaries must be convertible as [String: Any?], The dictionary ONLY contains elements that have changed..
     */
    mutating func overMerge(with dict: Dictionary, idKey: String = defaultIdKey, keys: Set<String>) -> [String: Any?]? {
        guard var actualDict = self as? [String: Any?], let dictToMerge = dict as? [String: Any?] else {
            return nil
        }
        var firstLvlChangesDict: [String: Any?] = [:]
        for key in keys {
            if let valDict = dictToMerge[key] as? [String: Any] {
                /// If selfDict has the dictionary for key, update the current dictionary with the new one and save
                var selfDict = actualDict[key] as? [String: Any] ?? [:]
                guard let changes = selfDict.merge(with: valDict, idKey: idKey) else { continue }
                actualDict[key] = selfDict
                firstLvlChangesDict[key] = changes
            } else if let valArray = dictToMerge[key] as? [[String: Any]] {
                actualDict[key] = valArray
            } else if let newValue = dictToMerge[key] {
                if let currentValue = actualDict[key] {
                    if String(describing: currentValue) != String(describing: newValue) {
                        actualDict[key] = newValue
                        firstLvlChangesDict[key] = newValue
                    }
                } else {
                    actualDict[key] = newValue
                    firstLvlChangesDict[key] = newValue
                }
            } else {
                if actualDict[key] != nil {
                    actualDict[key] = nil
                    firstLvlChangesDict[key] = nil
                }
            }
        }
        if let q = actualDict as? Self {
            self = q
        }
        return firstLvlChangesDict.isEmpty ? nil : firstLvlChangesDict
    }
}

