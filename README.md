# swift-url-routing-form-coding

![Development Status](https://img.shields.io/badge/status-active--development-orange.svg)

Form-coded request bodies for [swift-url-routing](https://github.com/swift-foundations/swift-url-routing) routes.

> The url-routing × form-coding integration package: routes that parse or
> print `application/x-www-form-urlencoded` bodies reach for one small
> bridge instead of the host packages vending the glue themselves.

## Overview

`import URL_Routing_Form_Coding` provides:

- `Conversion.form(_:decoder:encoder:)` — a typed conversion between a
  `Codable` value and URL-encoded form data, for use with `Body(.form(...))`
  in route definitions.
- A chaining `form(_:decoder:encoder:)` on any conversion whose output is
  form data.

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/swift-foundations/swift-url-routing-form-coding.git", branch: "main")
]
```

```swift
.target(
    name: "YourTarget",
    dependencies: [
        .product(name: "URL Routing Form Coding", package: "swift-url-routing-form-coding")
    ]
)
```

## Quick Start

```swift
import URL_Routing_Form_Coding

struct LoginRequest: Codable {
    let username: String
    let password: String
}

Route {
    Method.post
    Path { "login" }
    Body(.form(LoginRequest.self))
}
```

## License

Licensed under the [Apache License, Version 2.0](LICENSE.md).
