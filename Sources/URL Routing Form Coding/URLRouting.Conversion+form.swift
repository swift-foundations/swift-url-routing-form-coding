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

public import URLFormCoding
public import URLRouting

extension URLRouting.Conversion {
    /// Creates a URL form data conversion for the specified Codable type.
    ///
    /// This static method provides a convenient way to create ``Form/Conversion``
    /// instances for use in URLRouting route definitions. Form coding handles
    /// standard web form data (application/x-www-form-urlencoded).
    ///
    /// - Parameters:
    ///   - type: The Codable type to convert to/from form data
    ///   - decoder: Optional custom URL form decoder (uses default if not provided)
    ///   - encoder: Optional custom URL form encoder (uses default if not provided)
    /// - Returns: A ``Form/Conversion`` conversion instance
    ///
    /// ## Example
    ///
    /// ```swift
    /// struct LoginRequest: Codable {
    ///     let username: String
    ///     let password: String
    /// }
    ///
    /// // Create conversion with default encoder/decoder
    /// let loginConversion = Conversion.form(LoginRequest.self)
    ///
    /// // Create conversion with custom configuration
    /// let decoder = Form.Decoder()
    /// decoder.parsingStrategy = .brackets
    /// let encoder = Form.Encoder()
    /// encoder.dateEncodingStrategy = .iso8601
    ///
    /// let customConversion = Conversion.form(
    ///     LoginRequest.self,
    ///     decoder: decoder,
    ///     encoder: encoder
    /// )
    /// ```
    ///
    /// ## Usage in Routes
    ///
    /// ```swift
    /// Route {
    ///     Method.post
    ///     Path { "login" }
    ///     Body(.form(LoginRequest.self))
    /// }
    /// ```
    public static func form<Value>(
        _ type: Value.Type,
        decoder: Form.Decoder = .init(),
        encoder: Form.Encoder = .init()
    ) -> Self where Self == Form.Conversion<Value> {
        .init(type, decoder: decoder, encoder: encoder)
    }

    /// Maps this conversion through a URL form data conversion.
    ///
    /// This method allows you to chain conversions, applying form data
    /// conversion after another conversion has been applied.
    ///
    /// - Parameters:
    ///   - type: The Codable type to convert to/from form data
    ///   - decoder: Optional custom URL form decoder (uses default if not provided)
    ///   - encoder: Optional custom URL form encoder (uses default if not provided)
    /// - Returns: A mapped conversion that applies both conversions in sequence
    public func form<Value>(
        _ type: Value.Type,
        decoder: Form.Decoder = .init(),
        encoder: Form.Encoder = .init()
    ) -> Parser.Conversion.Map<Self, Form.Conversion<Value>> {
        self.map(.form(type, decoder: decoder, encoder: encoder))
    }
}
