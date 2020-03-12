@testable import Swiftagram
import XCTest

#if canImport(Combine)
import Combine

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
final class SwiftagramCombineTests: XCTestCase {
    /// The current cancellable.
    var requestCancellable: AnyCancellable?

    /// Test `Request`.
    func testStringRequest() {
        #if canImport(Combine)
        let expectation = XCTestExpectation()
        requestCancellable = Endpoint.generic
            .publish(response: String.self)
            .sink(receiveCompletion: {
                switch $0 {
                case .failure(let error): XCTFail(error.localizedDescription)
                default: break
                }
                expectation.fulfill()
            }, receiveValue: { _ in })
        wait(for: [expectation], timeout: 5)
        #endif
    }

    /// Test `Request`.
    func testRequest() {
        #if canImport(Combine)
        let expectation = XCTestExpectation()
        requestCancellable = Endpoint.generic
            .publish()
            .sink(receiveCompletion: {
                switch $0 {
                case .failure(let error): XCTFail(error.localizedDescription)
                default: break
                }
                expectation.fulfill()
            }, receiveValue: { _ in })
        wait(for: [expectation], timeout: 5)
        #endif
    }

    static var allTests = [
        ("Request", testRequest),
        ("Request.String", testStringRequest)
    ]
}
#endif