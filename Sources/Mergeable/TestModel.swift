//
//  File.swift
//  
//
//  Created by Ita on 7/6/20.
//

import Foundation

struct TestModel: Mergeable {
    var _id: String?
    var name: String?
    var code: Int?
}

extension TestModel {
    mutating func merge<T: Mergeable>(with obj: T) -> T?  {
        guard let objTM = obj as? TestModel, let id = self._id, let extId = objTM._id, id == extId else {
            return nil
        }
        let changes = self.merge(with: obj)
        return changes
    }
}

