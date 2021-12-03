import Foundation

public extension Data {
    enum ResourceError: Error { case resourceNotFound }

    init(contentsOfFile fileName: String) throws {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: nil) else {
            throw ResourceError.resourceNotFound
        }

        try self.init(contentsOf: url)
    }
}
