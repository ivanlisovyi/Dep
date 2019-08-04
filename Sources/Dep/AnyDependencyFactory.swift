//
//  AnyDependencyFactory.swift
//  Dep
//
//  Created by Ivan Lisovyi on 01.08.2019.
//  Copyright © 2019 Ivan Lisovyi. All rights reserved.
//

import Foundation

/// A type-erasing dependency factory that creates dependency instance when called.
final class AnyDependencyFactory {
    private let wrappedResolve: (Resolver) -> Any
    
    /// Initializes the factory object with the given dependency creation closure.
    ///
    /// - Parameter factory: A closure that `resolve()` method executes.
    init(_ factory: @escaping (Resolver) -> Any) {
        self.wrappedResolve = factory
    }
    
    /// Resolve a dependency using a given `Resolver`
    ///
    /// - Parameter resolver: `Resolver` used to create dependency.
    func resolve(_ resolver: Resolver) -> Any {
        return wrappedResolve(resolver)
    }
}
