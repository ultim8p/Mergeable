//
//  File.swift
//  
//
//  Created by Ita on 7/2/20.
//

import Foundation

extension Array where Iterator.Element == [String: Any] {
    /// Merge an array of dictionaries with the current array-
    /// Objects with equal _id fields will be merged.
    /// - Parameters:
    ///     - dicts: Array of dictionaries to merge with the current one.
    /// - Returns: Set of dictionaries that were updated containing only the updated fields.
    mutating func merge(with dicts: [[String: Any]]) -> [Element]? {
        var changes: Self = []
        for dict in dicts {
            guard let change = self.upsert(dict: dict) else { continue }
            changes.append(change)
        }
        return changes.isEmpty ? nil : changes
    }
    
    /// Check wheather the dictionaries in the array contain "id" values.
    /// - Returns: true if objects contain "id" field.
    func hasIds() -> Bool {
        var index = 0
        for dict in self {
            let objId = dict["_id"] as? String
            if objId != nil {
                return true
            }
            index += 1
            if index > 3 {
                return false
            }
        }
        return false
    }
    
    /// Updates or inserts a dictionary into the array.
    /// If dictionary with the same id exists, it will be updated with the new values.
    /// If dictionary does not exist, it will be inserted at index 0.
    /// - Parameters:
    ///     - dict: Dictionary to merge into the array.
    /// - Returns: Dictionary containing only the updated fields.
    mutating func upsert(dict: [String: Any]) -> [String: Any]? {
        let dictId = dict["_id"] as? String
        let dictQ = self.dict(with: dictId)
        if var foundDict = dictQ.0, let foundIndex = dictQ.1 {
            guard let changes = foundDict.merge(with: dict) else { return nil }
            self[foundIndex] = foundDict
            return changes
        } else {
            self.insert(dict, at: 0)
            return dict
        }
    }
    
    /// Find a dictionary with a specific id.
    /// - Parameters:
    ///     - id: Id to search for.
    /// - Returns: Dictionary with the specified id. Index of the object found.
    func dict(with id: String?) -> ([String: Any]?, Int?) {
        if let id = id {
            var index: Int = 0
            for dict in self {
                if let dictId = dict["_id"] as? String {
                    if dictId == id {
                        return (dict, index)
                    }
                }
                index += 1
            }
        }
        return (nil, nil)
    }
    
}
