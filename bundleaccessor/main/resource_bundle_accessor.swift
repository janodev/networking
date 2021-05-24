import class Foundation.Bundle

// This file is only used when using a xcodegen-generated project.
// Otherwise this file should not be in the path.

private class BundleFinder {}

extension Foundation.Bundle {
    static var module = Bundle(for: BundleFinder.self)
}
