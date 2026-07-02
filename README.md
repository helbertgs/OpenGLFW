# OpenGLAD

![License](https://img.shields.io/badge/License-MIT-green) ![Swift](https://img.shields.io/badge/Swift-6.0%20%7C%206.1%20%7C%206.2%20%7C%206.3-orange.svg) ![Platforms](https://img.shields.io/badge/Platforms-macOS%20%7C%20Linux%20%7C%20Windows-blue) [![CI](https://github.com/helbertgs/OpenGLFW/actions/workflows/ci.yml/badge.svg)](https://github.com/helbertgs/OpenGLFW/actions/workflows/ci.yml)

OpenGLFW is a cross-platform Swift Package that wraps [GLFW 3](https://www.glfw.org/), is a multi-platform library for OpenGL, OpenGL ES and Vulkan application development. 
It provides a simple, platform-independent API for creating windows, contexts and surfaces, reading input, handling events, etc.

GLFW natively supports Windows, macOS and Linux and other Unix-like systems. On Linux both X11 and Wayland are supported.

---

## Features

- `C/Swift` interoperability via module map
- Cross-platform support (`Windows`, `Linux`, `macOS`)
- Generated from [glfw3 3.4](https://github.com/glfw/glfw/releases/tag/3.4)

---

## Requirements

| Tool  | Version        |
|-------|---------------|
| Swift | 6.0+          |
| OS    | macOS 13+, Ubuntu 22.04+, Windows 10+ |

---

Add the package to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/helbertgs/OpenGLFW.git", from: "1.0.0")
],
targets: [
    .target(
        name: "YourTarget",
        dependencies: ["OpenGLFW"]
    )
]
```

## License

This package is licensed under the [MIT License](LICENSE).
The bundled [GLFW](https://www.glfw.org/) is licensed under [zlib/libpng license](https://www.glfw.org/license.html)