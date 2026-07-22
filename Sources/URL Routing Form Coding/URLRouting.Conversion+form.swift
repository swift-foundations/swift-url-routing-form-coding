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
