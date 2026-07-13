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

// Re-exports both halves of the bridge so `import URL_Routing_Form_Coding`
// is a self-contained surface: the routing vocabulary and the form coders
// both appear in the vended API.

@_exported public import URLFormCoding
@_exported public import URLRouting
