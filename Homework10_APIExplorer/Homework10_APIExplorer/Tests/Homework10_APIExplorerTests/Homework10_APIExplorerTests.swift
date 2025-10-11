//
//  Homework10_APIExplorerTests.swift
//  Homework10_APIExplorerTests
//
//  Created by Berkay Emre Aslan on 24.09.2025.
//

import XCTest
@testable import Homework10_APIExplorer

final class NetworkServiceTests: XCTestCase {

    func testDecodeCharacters_Succeeds() async throws {
        let json = """
        {"info":{"count":1,"pages":1,"next":null,"prev":null},
         "results":[{"id":1,"name":"Rick","status":"Alive","species":"Human","gender":"Male","image":"https://example.com/1.png"}]}
        """
        let cfg = URLSessionConfiguration.ephemeral
        cfg.protocolClasses = [MockURLProtocol.self]
        MockURLProtocol.requestHandler = { _ in
            let resp = HTTPURLResponse(url: URL(string:"https://x")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (resp, Data(json.utf8))
        }

        let service = NetworkService(session: URLSession(configuration: cfg))
        let page: PagedResponse<Character> = try await service.get(URL(string: "https://x")!)
        XCTAssertEqual(page.results.first?.name, "Rick")
    }

    func testDecodeCharacters_404() async {
        let cfg = URLSessionConfiguration.ephemeral
        cfg.protocolClasses = [MockURLProtocol.self]
        MockURLProtocol.requestHandler = { _ in
            let resp = HTTPURLResponse(url: URL(string:"https://x")!, statusCode: 404, httpVersion: nil, headerFields: nil)!
            return (resp, Data())
        }

        let service = NetworkService(session: URLSession(configuration: cfg))
        do {
            let _: PagedResponse<Character> = try await service.get(URL(string:"https://x")!)
            XCTFail("404 bekleniyordu, ancak hata fırlatılmadı")
        } catch let NetworkError.statusCode(code) {
            XCTAssertEqual(code, 404)
        } catch {
            XCTFail("Yanlış hata türü: \(error)")
        }
    }

    func testDecodeCharacters_BadJSON() async {
        let bad = #"{"info":{},"results":[{"id":"not-an-int"}]}"#
        let cfg = URLSessionConfiguration.ephemeral
        cfg.protocolClasses = [MockURLProtocol.self]
        MockURLProtocol.requestHandler = { _ in
            let resp = HTTPURLResponse(url: URL(string:"https://x")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (resp, Data(bad.utf8))
        }

        let service = NetworkService(session: URLSession(configuration: cfg))
        do {
            let _: PagedResponse<Character> = try await service.get(URL(string:"https://x")!)
            XCTFail("Decoding hatası bekleniyordu")
        } catch NetworkError.decoding {
        } catch {
            XCTFail("Yanlış hata türü: \(error)")
        }
    }
}

// MARK: - Mock
final class MockURLProtocol: URLProtocol {
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))!

    override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }

    override func startLoading() {
        guard let handler = Self.requestHandler else {
            client?.urlProtocol(self, didFailWithError: URLError(.badServerResponse))
            return
        }
        do {
            let (resp, data) = try handler(request)
            client?.urlProtocol(self, didReceive: resp, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    override func stopLoading() {}
}
