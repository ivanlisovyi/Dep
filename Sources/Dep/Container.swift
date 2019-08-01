//
//  Container.swift
//  Dep
//
//  Created by Ivan Lisovyi on 01.08.2019.
//  Copyright © 2019 Ivan Lisovyi. All rights reserved.
//

import Foundation

struct Container: Resolver {
    let factories: [AnyDependencyFactory]
    
    init() {
        factories = []
    }
    
    private init(factories: [AnyDependencyFactory]) {
        self.factories = factories
    }
    
    func register<Dependency>(_ type: Dependency.Type, _ factory: @escaping (Resolver) -> Dependency) -> Container {
        return .init(factories: factories + [AnyDependencyFactory({ resolver -> Any in
            factory(resolver)
        })])
    }
    
    func resolve<Dependency>(_ type: Dependency.Type) -> Dependency {
        let allResolved = factories.compactMap { $0.resolve(self) as? Dependency }
        guard let dependency = allResolved.first else {
            preconditionFailure("Cannot find depedency for type \(String(describing: type))")
        }
        
        return dependency
    }
}
