//
//  DependencyTests.swift
//  EngekiTests
//
//  Created by Ivan Lisovyi on 30.07.2019.
//  Copyright © 2019 Ivan Lisovyi. All rights reserved.
//

import XCTest

@testable import Dep

class DependencyTests: XCTestCase {
    private class FakeDependency {
        func doFake() -> Int {
            return 1
        }
    }
    
    @Dependency(container: Container().register(FakeDependency.self) { _ in FakeDependency() })
    private var dependency: FakeDependency
    
    func testThatItInjectsDependency() {
        XCTAssertNotNil(dependency)
        XCTAssertTrue(dependency.doFake() == 1)
    }
    
    static var allTests = [
        ("testInject", testThatItInjectsDependency)
    ]
}
