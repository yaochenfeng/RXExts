import Foundation
import Logging

@_exported import RxSwift

public typealias Logger = Logging.Logger

public extension Logger {
    init(rx cls: AnyClass) {
        let name = Bundle(for: cls).bundleIdentifier ?? "unkown"
        self.init(label: name.lowercased())
    }
}
