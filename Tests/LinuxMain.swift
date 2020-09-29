import XCTest

import CoordinatorTests

var tests = [XCTestCaseEntry]()
tests += CoordinatorTests.allTests()
tests += RouterTests.allTests()
XCTMain(tests)
