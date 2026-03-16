# swift-figma-api

A Swift client for the [Figma REST API](https://www.figma.com/developers/api) with async/await, rate limiting, and automatic retry with exponential backoff.

## Features

- 8 Figma API endpoints (files, components, nodes, images, styles, variables)
- Token-bucket rate limiting with fair round-robin scheduling
- Exponential backoff retry with jitter and `Retry-After` support
- Figma Variables API (read + write codeSyntax)
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

// Create a client with your Figma personal access token
let client = RateLimitedClient(
    inner: FigmaClient(accessToken: "your-figma-token")
)

// Fetch components
let components = try await client.request(
    ComponentsEndpoint(fileId: "your-file-id")
)

// Fetch variables
let variables = try await client.request(
    VariablesEndpoint(fileId: "your-file-id")
)

// Export images as SVG
let images = try await client.request(
    ImageEndpoint(fileId: "your-file-id", nodeIds: ["1:2", "3:4"], format: .svg)
)
```

## License

MIT
