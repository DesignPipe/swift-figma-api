# swift-figma-api

[![CI](https://github.com/DesignPipe/swift-figma-api/actions/workflows/ci.yml/badge.svg)](https://github.com/DesignPipe/swift-figma-api/actions/workflows/ci.yml)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FDesignPipe%2Fswift-figma-api%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/DesignPipe/swift-figma-api)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FDesignPipe%2Fswift-figma-api%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/DesignPipe/swift-figma-api)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://github.com/DesignPipe/swift-figma-api/blob/main/LICENSE)

A Swift client for the [Figma REST API](https://www.figma.com/developers/api) with async/await, rate limiting, and automatic retry with exponential backoff.

## Features

- Full Figma REST API coverage (46 endpoints) — files, components, styles, variables, comments, webhooks, dev resources, analytics, and more
- Token-bucket rate limiting with fair round-robin scheduling
- Exponential backoff retry with jitter and `Retry-After` support
- Figma Variables API (read local, read published, write codeSyntax)
- Support for both API v1 and v2 (webhooks)
- GitHub Releases endpoint (for version checking)
- Swift 6 strict concurrency

## Requirements

- Swift 6.1+
- macOS 13+ / Linux (Ubuntu 22.04+)

## Installation

Add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/DesignPipe/swift-figma-api.git", from: "0.1.0"),
]
```

Then add `FigmaAPI` to your target dependencies:

```swift
.target(
    name: "YourTarget",
    dependencies: [
        .product(name: "FigmaAPI", package: "swift-figma-api"),
    ]
)
```

## Usage

```swift
import FigmaAPI

// Create a client
let figma = FigmaClient(accessToken: "your-figma-token", timeout: nil)

// Wrap with rate limiting and retry
let rateLimiter = SharedRateLimiter()
let client = RateLimitedClient(
    client: figma,
    rateLimiter: rateLimiter,
    configID: "default"
)

// Fetch components from a file
let components = try await client.request(
    ComponentsEndpoint(fileId: "your-file-id")
)

// Fetch variables
let variables = try await client.request(
    VariablesEndpoint(fileId: "your-file-id")
)

// Export images as SVG
let images = try await client.request(
    ImageEndpoint(fileId: "your-file-id", nodeIds: ["1:2", "3:4"], params: SVGParams())
)

// Get current user
let me = try await client.request(GetMeEndpoint())

// Post a comment
let comment = try await client.request(
    PostCommentEndpoint(
        fileId: "your-file-id",
        body: PostCommentBody(message: "Looks great!")
    )
)

// List webhooks (v2 API)
let webhooks = try await client.request(GetWebhooksEndpoint())
```

## License

MIT
