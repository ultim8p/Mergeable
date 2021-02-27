//
//  File.swift
//  
//
//  Created by Ita on 7/2/20.
//

import Foundation

enum CompareResult {
    case equal
    case greater
    case lower
}

extension Dictionary where Key == String, Value == Any {
    func compare(to key: String, val: Any?) -> CompareResult? {
        guard let value = self[key], let valueToCompare = val else { return nil }
        if let eqActVal = value as? Int, let eqCmpValue = valueToCompare as? Int {
            return eqActVal == eqCmpValue ? .equal : (eqActVal < eqCmpValue ? .lower : .greater)
        } else if let eqActVal = value as? String, let eqCmpValue = valueToCompare as? String {
            return eqActVal == eqCmpValue ? .equal : (eqActVal < eqCmpValue ? .lower : .greater)
        } else if let eqActVal = value as? Double, let eqCmpValue = valueToCompare as? Double {
            return eqActVal == eqCmpValue ? .equal : (eqActVal < eqCmpValue ? .lower : .greater)
        } else if let eqActVal = value as? Date, let eqCmpValue = valueToCompare as? Date {
            return eqActVal == eqCmpValue ? .equal : (eqActVal < eqCmpValue ? .lower : .greater)
        } else if let eqActVal = value as? Float, let eqCmpValue = valueToCompare as? Float {
            return eqActVal == eqCmpValue ? .equal : (eqActVal < eqCmpValue ? .lower : .greater)
        } else {
            return nil
        }
    }
}

public extension Array where Iterator.Element == [String: Any] {
    /// Merge an array of dictionaries with the current array.
    /// Objects with equal id fields will be merged.
    /// - Parameters:
    ///     - dicts: Array of dictionaries to merge with the current one.
    ///     - idKey: Name of id fields inside the dictionaries.
    /// - Returns: Set of dictionaries that were updated containing only the updated fields.
    mutating func merge(with dicts: [[String: Any]], idKey: String = defaultIdKey) -> [Element]? {
        var changes: Self = []
        for dict in dicts {
            guard let change = self.upsert(dict: dict, idKey: idKey) else { continue }
            changes.append(change)
        }
        return changes.isEmpty ? nil : changes
    }
    
    /// Check wheather the dictionaries in the array contain id values.
    /// - Parameters:
    ///     - idKey: Key used as ids in the array of dictionaries.
    /// - Returns: true if objects contain id field.
    func hasIds(idKey: String = defaultIdKey) -> Bool {
        var index = 0
        for dict in self {
            let objId = dict[idKey] as? String
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
    ///     - idKey: Unique identifier key name to merge unique dictionaries together.
    /// - Returns: Dictionary containing only the updated fields.
    mutating func upsert(dict: [String: Any], idKey: String) -> [String: Any]? {
        let dictId = dict[idKey] as? String
        let dictQ = self.dict(with: idKey, value: dictId)
        if var foundDict = dictQ.0, let foundIndex = dictQ.1 {
            guard let changes = foundDict.merge(with: dict, idKey: idKey) else { return nil }
            self[foundIndex] = foundDict
            return changes
        } else {
            self.insert(dict, at: 0)
            return dict
        }
    }
    
    /// Find a dictionary with a specific key value pair.
    /// - Parameters:
    ///     - key: Name of the key to search for.
    ///     - value: Value to search for.
    /// - Returns: Dictionary with the specified id. Index of the object found.
    func dict(with key: String, value: Any?) -> ([String: Any]?, Int?) {
        guard let val = value else { return (nil, nil) }
        
        var index: Int = 0
        for dict in self {
            if dict.compare(to: key, val: val) == .equal {
                return (dict, index)
            }
            index += 1
        }
        
        return (nil, nil)
    }
    
}
