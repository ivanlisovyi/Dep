//
//  ContainerTests.swift
//  EngekiTests
//
//  Created by Ivan Lisovyi on 10.07.2019.
//  Copyright © 2019 Ivan Lisovyi. All rights reserved.
//

import XCTest

@testable import Dep

class ContainerTests: XCTestCase {
    private class FakeDependency {
        func doFake() -> Int {
            return 1
        }
    }
    
    private class CompoundFakeDependency {
        let fake: FakeDependency
        init(fake: FakeDependency) {
            self.fake = fake
        }
        
        func doFake() -> Int {
            return self.fake.doFake() + 1
        }
    }
    
    private var container: Container?

    override func setUp() {
        container = Container()
    }

    override func tearDown() {
        container = nil
    }

    func testThatItRegistersDependency() {
        container = container?.register(FakeDependency.self, { _ in
            return FakeDependency()
        })
        XCTAssertEqual(container?.factories.count, 1)
    }
    
    func testThatItResolvesDependency() {
        container = container?.register(FakeDependency.self, { _ in
            return FakeDependency()
        })
        
        let dependency = container?.resolve(FakeDependency.self)
        XCTAssertNotNil(dependency)
    }
    
    func testThatItCreatesNewInstanceEveryTime() {
        container = container?.register(FakeDependency.self, { _ in
            return FakeDependency()
        })
        
        let first = container?.resolve(FakeDependency.self)
        let second = container?.resolve(FakeDependency.self)
        
        XCTAssertFalse(first === second)
    }
    
    func testThatNewlyRegisteredDependencyOverwritesPreviouslyAdded() {
        class FakeDependencyTwo: FakeDependency {
            override func doFake() -> Int {
                return 2
            }
        }
        
        container = container?.register(FakeDependency.self, { _ in FakeDependency() })
        let first = container?.resolve(FakeDependency.self)
        
        container = container?.register(FakeDependency.self, { _ in FakeDependencyTwo() })
        let second = container?.resolve(FakeDependency.self)
        
        XCTAssertFalse(first?.doFake() == second?.doFake())
    }
    
    static var allTests = [
        ("testRegister", testThatItRegistersDependency),
        ("testResolve", testThatItResolvesDependency),
        ("testNewInstance", testThatItCreatesNewInstanceEveryTime)
    ]
}
