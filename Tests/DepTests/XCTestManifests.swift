import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ContainerTests.allTests),
        testCase(DependencyTests.allTests)
    ]
}
#endif
