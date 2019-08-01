import XCTest

import DepTests

var tests = [XCTestCaseEntry]()
tests += DepTests.allTests()
XCTMain(tests)
