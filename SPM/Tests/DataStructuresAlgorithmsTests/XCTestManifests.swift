import XCTest

#if !canImport(ObjectiveC)
open func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(DataStructuresAlgorithmsTests.allTests)
    ]
}
#endif
