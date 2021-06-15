//
//  File.swift
//  
//
//  Created by Guerson Perez on 01/03/21.
//

import Foundation

public extension Buildable {
    func buld<T: Buildable>(type: T.Type, with changeKeys: Set<String>, idKey: String) -> T? {
        let selfDict = self.toDictionary()
        let objType = T.self
        if let builtDict = selfDict.build(with: changeKeys, idKey: idKey) {
            let builtObj = builtDict.toModel(objType)
            return builtObj
        }
        return nil
    }
}
