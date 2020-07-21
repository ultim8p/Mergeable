import XCTest
@testable import Mergeable

final class MergeableTests: XCTestCase {


    func testMerge(){
        var start = TestModel(_id: "01", name: "Start", code: 20)
        let startChanged =  TestModel(_id: "01", name: nil, code: 40)
        _ = start.merge(TestModel.self, with: startChanged)
        XCTAssertEqual(start.code, 40)
        XCTAssertEqual(start.name, "Start")

    }
    
    
    static var allTests = [
        ("testMerge", testMerge),
    ]
}

