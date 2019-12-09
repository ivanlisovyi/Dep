# Dep
[![Build Status](https://app.bitrise.io/app/567be5d243fe7062/status.svg?token=bj-LZASRzSQZx5HFI6aImA)](https://app.bitrise.io/app/567be5d243fe7062)

**Dep** is a micro framework that implements a dependency injection using the *Service Locator* pattern and provides a convenient way to use these dependencies using `@Dependency` property wrapper

## Examples

### Basic Usage Example
```swift
// Define a container and register your dependencies 
let container = Container()
       .register(AnyDecoder.self) { _ in JSONDecoder() }
       .register(AnyEncoder.self) { _ in JSONEncoder() }

// Resolve dependency using the previously defined container 
let dependency = container.resolve(AnyDecoder.self)
```

### Advanced Usage Example
It is possible to register a dependency that expect its dependencies injected onto it in some way. For this purpose use the `factory` closure parameter
```swift
let container = Container()
       .register(AnyDecoder.self) { _ in JSONDecoder() }
       .register(AnyEncoder.self) { _ in JSONEncoder() }
       .register(ComplexObject.self) { resolver in 
          let decoder = resolver.resolve(AnyDecoder.self)
          let encoder = resolver.resolve(AnyEncoder.self)
          return ComplexObject(decoder: decoder, encoder: encoder)
       }

// Resolve dependency using the previously defined container 
let dependency = container.resolve(ComplexObject.self)
```

### `@Dependency` Property Wrapper Usage
```swift
let defaultContainer = Container()
       .register(AnyDecoder.self) { _ in JSONDecoder() }
       .register(AnyEncoder.self) { _ in JSONEncoder() }


class ComplexObject {
  @Dependency(container: defaultContainer) var decoder: AnyDecoder 
  @Dependency(container: defaultContainer) var encoder: AnyEncoder
}
```

## Unit Testing
To test the classes that use `@Dependency` property wrapper it is possible to overwrite the container used to define a dependency
```swift
let testContainer = Container()
    .register(AnyDecoder.self) { _ in JSONDecoder() }
    .register(AnyEncoder.self) { _ in JSONEncoder() }
    .register(ComplexObject.self) { resolver in
        var result = ComplexObject()
        result.$decoder.container = resolver // overwrites decoder container
        result.$encoder.container = resolver
        return result
    }

class ComplexObjectsTests: XCTestCase {
  @Dependency(container: testContainer) var complexObject: ComplexObject

  func testThatItWorks() {
    XCTAssertTrue(complexObject.doesSomething())
  }
}
```

## Installation

### Swift Package Manager 
The Swift Package Manager is a tool for automating the distribution of Swift code and is integrated into the swift compiler.

Once you have your Swift package set up, adding Dep as a dependency is as easy as adding it to the dependencies value of your Package.swift or since XCode 11 you can do the same through XCode UI

```
dependencies: [
    .package(url: "https://github.com/kshin/Dep.git", from: "1.0.2")
]
```

## Requirements 
- Xcode 11 
- Swift 5.1 


## Licence 
The MIT License (MIT)

Copyright (c) 2019 Ivan Lisovyi

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
