//
//  Container.swift
//  Dep
//
//  Created by Ivan Lisovyi on 01.08.2019.
//  Copyright © 2019 Ivan Lisovyi. All rights reserved.
//

import Foundation

/// The default implementation of `Resolver` protocol.
///
/// Use `Container` instance to register and resolve dependencies of the certain kind.
///
/// **Example:**
///```
/// let container = Container()
///        .register(AnyDecoder.self) { _ in JSONDecoder() }
///        .register(AnyEncoder.self) { _ in JSONEncoder() }
///
/// let dependency = container.resolve(AnyDecoder.self)
/// ```
public struct Container: Resolver {
    /// The current known factories
    let factories: [ObjectIdentifier: Factory]
    
    public init() {
        factories = [:]
    }
    
    private init(factories: [ObjectIdentifier: Factory]) {
        self.factories = factories
    }
    
    /// Provides a way to register a closure-based factory for resolving dependencies of certain type.
    ///
    /// - Parameters:
    ///     - type: The type of dependency.
    ///     - factory: The closure-based factory that takes resolver as a parameter and returns
    ///     a dependency instance.
    /// - Returns: A `Resolver` instance.
    public func register<Dependency>(_ type: Dependency.Type, _ factory: @escaping Factory) -> Container {
        let key = ObjectIdentifier(type)
        let newFactories = factories.merging([key: factory]) { $1 }
        return .init(factories: newFactories)
    }
    
    /// Provides a way to resolve/create a dependency of certain type.
    ///
    /// - Precondition: The dependency creation factory must be registered beforehand.
    ///
    /// - Parameters:
    ///     - type The type of resolved dependency.
    /// - Returns: A `Dependency` instance.
    public func resolve<Dependency>(_ type: Dependency.Type) -> Dependency {
        guard let factory = factories[ObjectIdentifier(type)] else {
            preconditionFailure("Cannot find depedency for type \(String(describing: type))")
        }
        
        return factory(self) as! Dependency
    }
}
