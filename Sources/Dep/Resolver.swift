//
//  Resolver.swift
//  Dep
//
//  Created by Ivan Lisovyi on 01.08.2019.
//  Copyright © 2019 Ivan Lisovyi. All rights reserved.
//

import Foundation
import Combine

/// Declares a type that can register and resolves dependencies of certain kind.
///
/// Every Resolver must adhere to this contact.
public protocol Resolver {
    typealias Factory = (Resolver) -> Any
    
    /// Provides a way to register a closure-based factory for resolving dependencies of certain type.
    ///
    /// - Parameters:
    ///     - type: The type of dependency.
    ///     - factory: The closure-based factory that takes resolver as a parameter and returns
    ///     a dependency instance.
    /// - Returns: A `Resolver` instance.
    func register<Dependency>(_ type: Dependency.Type, _ factory: @escaping Factory) -> Container
    
    /// Provides a way to resolve/create a dependency of certain type.
    ///
    /// - Parameters:
    ///     - type The type of resolved dependency.
    /// - Returns: A `Dependency` instance.
    func resolve<Dependency>(_ type: Dependency.Type) -> Dependency
}
