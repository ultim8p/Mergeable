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
    var base: Int?
    var date: Date?
    var status: Int?
}

//MARK: Mergeable
extension TestModel {
    mutating func merge(with obj: TestModel) -> TestModel?  {
        guard let id = self._id, let extId = obj._id, id == extId else {
            return nil
        }
        let changes = self.merge(with: obj, idKey: "_id")
        return changes
    }
}

//MARK: OverMergeable
extension TestModel: OverMergeable {
    mutating func overMerge(with obj: TestModel, changeKeys: Set<String>) -> TestModel? {
        guard let currentId = obj._id, let newId = obj._id, currentId == newId else {
            return nil
        }
        let changes = self.overMerge(with: obj, idKey: "_id", changeKeys: changeKeys)
        return changes
    }
}

//MARK: Buildable
extension TestModel: Buildable {
    func buld(with changeKeys: Set<String>?) -> TestModel? {
        guard let changeKeys = changeKeys else {
            return nil
        }
        return self.buld(type: TestModel.self, with: changeKeys, idKey: "_id")
    }
}
