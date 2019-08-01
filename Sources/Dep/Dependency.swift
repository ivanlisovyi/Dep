//
//  Dependency.swift
//  Dep
//
//  Created by Ivan Lisovyi on 01.08.2019.
//  Copyright © 2019 Ivan Lisovyi. All rights reserved.
//

import Foundation

@propertyWrapper
struct Dependency<T> {
    private lazy var service: T = {
        return container.resolve(T.self)
    }()
    
    var container: Resolver
    
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
