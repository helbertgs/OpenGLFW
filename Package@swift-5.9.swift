// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

var sources: [String] = [
    "internal.h", "platform.h", "mappings.h",
    "context.c", "init.c", "input.c", "monitor.c", "platform.c", "vulkan.c", "window.c",
    "egl_context.c", "osmesa_context.c", "null_platform.h", "null_joystick.h",
    "null_init.c", "null_monitor.c", "null_window.c", "null_joystick.c"
]

#if os(macOS)
// Cocoa/NSGL
sources += [
    "cocoa_time.h", "cocoa_time.c", "posix_thread.h",
    "posix_module.c", "posix_thread.c"
]

sources += [
    "cocoa_platform.h", "cocoa_joystick.h", "cocoa_init.m",
    "cocoa_joystick.m", "cocoa_monitor.m", "cocoa_window.m",
    "nsgl_context.m"
]
#elseif os(Windows)
// Win32/WGL
sources += [
    "win32_time.h", "win32_thread.h", "win32_module.c",
    "win32_time.c", "win32_thread.c"
]

sources += [
    "win32_platform.h", "win32_joystick.h", "win32_init.c",
    "win32_joystick.c", "win32_monitor.c", "win32_window.c",
    "wgl_context.c"
]
#else
// Linux/X11
sources += [
    "posix_time.h", "posix_thread.h", "posix_module.c",
    "posix_time.c", "posix_thread.c",
    "linux_joystick.h", "linux_joystick.c",
    "posix_poll.h", "posix_poll.c"
]

sources += [
    "x11_platform.h", "xkb_unicode.h", "x11_init.c",
    "x11_monitor.c", "x11_window.c", "xkb_unicode.c",
    "glx_context.c"
]
#endif

let package = Package(
    name: "GLFW",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "GLFW",
            targets: ["GLFW"]
        )
    ],
    targets: [
        .target(
            name: "GLFW",
            sources: sources,
            cSettings: [
                .unsafeFlags(["-fno-objc-arc"], .when(platforms: [.macOS])),
                .define("_GLFW_COCOA", .when(platforms: [.macOS])),
                .define("GLFW_EXPOSE_NATIVE_COCOA", .when(platforms: [.macOS])),
                .define("GLFW_EXPOSE_NATIVE_NSGL", .when(platforms: [.macOS])),
                .define("_GLFW_WIN32", .when(platforms: [.windows])),
                .define("_GLFW_X11", .when(platforms: [.linux])),
                .define("_DEFAULT_SOURCE", .when(platforms: [.linux])),
                .define("GL_SILENCE_DEPRECATION", .when(platforms: [.macOS])),
            ],
            linkerSettings: [
                .linkedFramework("Cocoa", .when(platforms: [.macOS])),
                .linkedFramework("IOKit", .when(platforms: [.macOS])),
                .linkedFramework("CoreFoundation", .when(platforms: [.macOS])),
                .linkedFramework("QuartzCore", .when(platforms: [.macOS])),
                .linkedLibrary("OpenGL32", .when(platforms: [.windows])),
                .linkedLibrary("Gdi32", .when(platforms: [.windows]))            
            ]
        )
    ]
)
