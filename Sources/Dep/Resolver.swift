//
//  Resolver.swift
//  Dep
//
//  Created by Ivan Lisovyi on 01.08.2019.
//  Copyright © 2019 Ivan Lisovyi. All rights reserved.
//

import Foundation

protocol Resolver {
    func register<Dependency>(_ type: Dependency.Type, _ factory: @escaping (Resolver) -> Dependency) -> Container
    func resolve<Dependency>(_ type: Dependency.Type) -> Dependency
}
