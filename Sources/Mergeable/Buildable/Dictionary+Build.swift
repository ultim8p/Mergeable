//
//  File.swift
//  
//
//  Created by Guerson Perez on 01/03/21.
//

import Foundation

public extension Dictionary {
    func build(with changeKeys: Set<String>, idKey: String) -> [String: Any?]? {
        guard !changeKeys.isEmpty, let currentDict = self as? [String: Any?] else {
            return nil
        }
        var buildDict: [String: Any?] = [:]
        for key in changeKeys {
            let value = currentDict[key]
            buildDict[key] = value
        }
        let idValue = currentDict[idKey]
        buildDict[idKey] = idValue
        return buildDict
    }
}
