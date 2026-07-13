// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-url-routing-form-coding open source
// project
//
// Copyright (c) 2026 Coen ten Thije Boonkkamp and the
// swift-url-routing-form-coding project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// ===----------------------------------------------------------------------===//

import Foundation
import Testing

@testable import URL_Routing_Form_Coding

// Parallel-namespace suite: the vended surface extends a generic-constrained
// protocol and returns generic conversions, so there is no non-generic own
// type to host the suite.
@Suite
struct `URLRouting.Conversion+form Tests` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}

    struct Login: Codable, Equatable {
        let username: String
        let password: String
    }
}

extension `URLRouting.Conversion+form Tests`.Unit {
    private typealias Fixture = `URLRouting.Conversion+form Tests`.Login

    @Test
    func `form conversion round-trips a value through form data`() throws {
        let conversion: Form.Conversion<Fixture> = .form(Fixture.self)
        let value = Fixture(username: "coen", password: "s cret")

        let data = try conversion.unapply(value)
        let decoded = try conversion.apply(data)

        #expect(decoded == value)
    }

    @Test
    func `form conversion carries the supplied coders`() {
        let decoder = Form.Decoder()
        let encoder = Form.Encoder()

        let conversion: Form.Conversion<Fixture> = .form(
            Fixture.self,
            decoder: decoder,
            encoder: encoder
        )

        #expect(conversion.decoder === decoder)
        #expect(conversion.encoder === encoder)
    }
}

extension `URLRouting.Conversion+form Tests`.`Edge Case` {
    private typealias Fixture = `URLRouting.Conversion+form Tests`.Login

    @Test
    func `applying form data that misses required fields throws the routing error`() {
        let conversion: Form.Conversion<Fixture> = .form(Fixture.self)

        #expect(throws: RFC_3986.URI.Routing.Error.self) {
            try conversion.apply(Data())
        }
    }
}

extension `URLRouting.Conversion+form Tests`.Integration {
    private typealias Fixture = `URLRouting.Conversion+form Tests`.Login

    @Test
    func `wire-format form data decodes percent-encoded fields`() throws {
        let conversion: Form.Conversion<Fixture> = .form(Fixture.self)
        let wire = Data("username=coen&password=s%20cret".utf8)

        let decoded = try conversion.apply(wire)

        #expect(decoded == Fixture(username: "coen", password: "s cret"))
    }
}
