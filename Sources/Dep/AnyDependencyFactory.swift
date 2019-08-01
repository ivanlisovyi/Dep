//
//  AnyDependencyFactory.swift
//  Dep
//
//  Created by Ivan Lisovyi on 01.08.2019.
//  Copyright © 2019 Ivan Lisovyi. All rights reserved.
//

import Foundation

final class AnyDependencyFactory {
    private let wrappedResolve: (Resolver) -> Any
    
    init(_ factory: @escaping (Resolver) -> Any) {
        self.wrappedResolve = factory
    }
    
    func resolve(_ resolver: Resolver) -> Any {
        return wrappedResolve(resolver)
    }
}
