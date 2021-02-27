import XCTest
@testable import Mergeable

final class MergeableTests: XCTestCase {


    func testMerge(){
        var start = TestModel(_id: "01", name: "Loli", code: nil, base: 5, date: Date(), status: 3)
        let startChanged =  TestModel(_id: "01", name: nil, code: 8, base: 5, date: nil, status: 4)
        let _ = start.merge(with: startChanged)
        XCTAssertEqual(start.code, 8)
        XCTAssertEqual(start.name, "Loli")
    }
    
    func testOverMerge() {
        var start = TestModel(_id: "01", name: "Loli", code: nil, base: 5, date: Date(), status: 3)
        let startModified = TestModel(_id: "01", name: nil, code: 8, base: 5, date: nil, status: 4)
        let changeKeys: Set<String> = ["name", "code", "date", "status"]
        let changes = start.overMerge(with: startModified, changeKeys: changeKeys)
        XCTAssertNil(start.name)
        XCTAssertEqual(start.code, 8)
        XCTAssertNil(start.date)
        XCTAssertEqual(start.status, 4)
        XCTAssertNotNil(changes)
    }
    
    static var allTests = [
        ("testMerge", testMerge),
    ]
}

