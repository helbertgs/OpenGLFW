// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OpenGLFW",
    products: [
        .library(
            name: "OpenGLFW",
            targets: ["OpenGLFW"]
        )
    ],
    targets: [
        .target(
            name: "OpenGLFW",
            sources: OS.current.sources,
            cSettings: OS.current.cSettings,
            linkerSettings: OS.current.linkerSettings
        )
    ]
)

fileprivate enum OS {
    case macOS
    case linux
    case windows

    static var current: OS {
        #if os(macOS)
        .macOS
        #elseif os(Windows)
        .windows
        #else
        .linux
        #endif
    }

    // MARK: - Sources

    var sources: [String] {
        switch self {
            case .linux: coreSources + linuxSources
            case .macOS: coreSources + macOSSources
            case .windows: coreSources + windowsSources
        }
    }

    private var coreSources : [String] {[
        "context.c", "egl_context.c", "init.c", "input.c", "internal.h", "mappings.h",
        "monitor.c", "null_init.c", "null_joystick.c", "null_joystick.h", "null_monitor.c",
        "null_platform.h", "null_window.c", "osmesa_context.c", "platform.c", "platform.h",
        "vulkan.c", "window.c"
    ]}

    private var macOSSources : [String] {[
        "cocoa_init.m", "cocoa_joystick.h", "cocoa_joystick.m", "cocoa_monitor.m", 
        "cocoa_platform.h", "cocoa_time.c", "cocoa_time.h", "cocoa_window.m", 
        "nsgl_context.m", "posix_module.c", "posix_thread.c", "posix_thread.h"
    ]}

    private var windowsSources : [String] {[
        "win32_init.c", "win32_joystick.c", "win32_joystick.h", "win32_module.c", 
        "win32_monitor.c", "win32_platform.h", "win32_thread.c", "win32_thread.h", 
        "win32_time.c", "win32_time.h", "wgl_context.c", "win32_window.c"
    ]}

    private var linuxSources : [String] {[
        "glx_context.c", "linux_joystick.c", "linux_joystick.h", "posix_module.c", 
        "posix_poll.c", "posix_poll.h", "posix_time.c", "posix_time.h",
        "x11_init.c", "x11_monitor.c", "x11_platform.h", "x11_window.c", 
        "xkb_unicode.c", "xkb_unicode.h"
    ]}

    // MARK: - CSettings

    var cSettings: [CSetting]? {
        switch self {
            case .linux: linuxCSettings
            case .macOS: macOSCSettings
            case .windows: windowsCSettings
        }
    }

    private var macOSCSettings: [CSetting]? {[
        .unsafeFlags(["-fno-objc-arc"], .when(platforms: [.macOS])),
        .define("GL_SILENCE_DEPRECATION", .when(platforms: [.macOS])),
        .define("_GLFW_COCOA", .when(platforms: [.macOS])),
        .define("GLFW_EXPOSE_NATIVE_COCOA", .when(platforms: [.macOS])),
        .define("GLFW_EXPOSE_NATIVE_NSGL", .when(platforms: [.macOS])),
    ]}

    private var linuxCSettings: [CSetting]? {[
        .define("_GLFW_X11", .when(platforms: [.linux])),
        .define("_DEFAULT_SOURCE", .when(platforms: [.linux])),
    ]}

    private var windowsCSettings: [CSetting]? {[
        .define("_CRT_SECURE_NO_WARNINGS", .when(platforms: [.windows])),
        .define("_GLFW_WIN32", .when(platforms: [.windows])),
    ]}

    // MARK: - Linker Settings

    var linkerSettings: [LinkerSetting]? {
        switch self {
            case .linux: linuxLinkerSettings
            case .macOS: macOSLinkerSettings
            case .windows: windowsLinkerSettings
        }
    }

    private var linuxLinkerSettings: [LinkerSetting]? {
        nil
    }

    private var macOSLinkerSettings: [LinkerSetting]? {[
        .linkedFramework("Cocoa", .when(platforms: [.macOS])),
        .linkedFramework("IOKit", .when(platforms: [.macOS])),
        .linkedFramework("CoreFoundation", .when(platforms: [.macOS])),
        .linkedFramework("QuartzCore", .when(platforms: [.macOS])),
    ]}

    private var windowsLinkerSettings: [LinkerSetting]? {[
        .linkedLibrary("OpenGL32", .when(platforms: [.windows])),
        .linkedLibrary("Gdi32", .when(platforms: [.windows]))    
    ]}
}