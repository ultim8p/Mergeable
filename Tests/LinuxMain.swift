import XCTest

import MergeableTests

var tests = [XCTestCaseEntry]()
tests += MergeableTests.allTests()
XCTMain(tests)
