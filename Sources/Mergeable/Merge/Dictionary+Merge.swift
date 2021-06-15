//
//  RFModel.swift
//  RiseFit
//
//  Created by Guerson on 2018-07-14.
//  Copyright © 2018 Rise. All rights reserved.
//

import Foundation

public extension Dictionary {
    
    /// Merge a dictionary into the current dictionary.
    /// Only new values in the dictionary will be updated.
    /// If dictionaries use id fields, dictionaries with equal ids will be merged together.
    /// - Parameters:
    ///     - dict: Dictionary to merge into the current dictionary.
    ///     - idKey: Name of id fields inside the dictionaries.
    /// - Returns: Dictionary containing only updated fields.
    mutating func merge(with dict: Dictionary, idKey: String = defaultIdKey) -> Dictionary? {
        var firstLvlChangesDict: Dictionary = [:]
        for (key, val) in dict {
            if let valDict = val as? [String: Any] {
                /// If selfDict has the dictionary for key, update the current dictionary with the new one and save
                var selfDict = self[key] as? [String: Any] ?? [:]
                guard let changes = selfDict.merge(with: valDict, idKey: idKey) else { continue }
                if let selfDictVal = selfDict as? Value {
                    if let changesVal = changes as? Value {
                        firstLvlChangesDict[key] = changesVal
                    }
                    self[key] = selfDictVal
                }
            } else if let valArray = val as? [[String: Any]] {
                /// If its an array of objects with ids, perform an upsert operation for each object,
                /// else replace the whole object with the new array of objects
//                if valArray.hasIds(idKey: idKey) {
//                    var selfDicts = self[key] as? [[String: Any]] ?? []
//                    guard let changes = selfDicts.merge(with: valArray, idKey: idKey) else { continue }
//                    if let selfDictsVal = selfDicts as? Value {
//                        if let changesVal = changes as? Value {
//                            firstLvlChangesDict[key] = changesVal
//                        }
//                        self[key] = selfDictsVal
//                    }
//                } else {
                    if let valArrayVal = valArray as? Value {
                        self[key] = valArrayVal
                    }
//                }
            } else if let currentValue = self[key]  {
                if String(describing: currentValue) != String(describing: val) {
                    firstLvlChangesDict[key] = val
                    self[key] = val
                }
            } else {
                firstLvlChangesDict[key] = val
                self[key] = val
            }
        }
        if !firstLvlChangesDict.isEmpty {
            return firstLvlChangesDict
        }
        return nil
    }
}



