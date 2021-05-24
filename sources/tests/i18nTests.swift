@testable import Networking
import XCTest

final class i18nTests: XCTestCase {

    func testResources() {
        i18n.allCases.forEach { instance in
            guard instance.localizedDescription != instance.rawValue else {
                XCTFail("\(instance.rawValue) is missing a translation.")
                return
            }
        }
    }
}
