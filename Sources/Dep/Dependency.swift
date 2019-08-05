//
//  Dependency.swift
//  Dep
//
//  Created by Ivan Lisovyi on 01.08.2019.
//  Copyright © 2019 Ivan Lisovyi. All rights reserved.
//

import Foundation

/// A property wrapper which injects a dependency into another object.
///
/// `Dependency` property wrapper implemented using Service Locator
/// under the hood. The property wrapper expect a dependency container to
/// be provided.
///
/// **Example:**
/// ```
/// @Dependency(container: #someContainer#) var someDependency: DependencyType;
/// ```
@propertyWrapper
struct Dependency<T> {
    private lazy var service: T = {
        return container.resolve(T.self)
    }()
    
    var container: Resolver
    
    /// Creates a property wrapper using a container to find
    /// and resolve the dependency instance.
    /// - Parameter container: A `Resolver` instance where dependency can be found.
    init(container: Resolver) {
        self.container = container
    }
    
    var wrappedValue: T {
        mutating get {
            return service
        }
    }
    
    var projectedValue: Self {
        get { self }
        set { self = newValue }
    }
}
