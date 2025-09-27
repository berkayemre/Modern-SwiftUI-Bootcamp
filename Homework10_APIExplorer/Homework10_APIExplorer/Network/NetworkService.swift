//
//  NetworkService.swift
//  Homework10_APIExplorer
//
//  Created by Berkay Emre Aslan on 24.09.2025.
//

import Foundation

protocol Networking {
    func get<T: Decodable>(_ url: URL) async throws -> T
}

final class NetworkService: Networking {
    private let session: URLSession
    init(session: URLSession = .shared) { self.session = session }

    func get<T: Decodable>(_ url: URL) async throws -> T {
        let (data, resp) = try await session.data(from: url)
        guard let http = resp as? HTTPURLResponse else { throw NetworkError.invalidResponse }
        guard 200..<300 ~= http.statusCode else { throw NetworkError.statusCode(http.statusCode) }
        do { return try JSONDecoder().decode(T.self, from: data) }
        catch { throw NetworkError.decoding(error) }
    }
}

enum NetworkError: Error {
    case invalidResponse, statusCode(Int), decoding(Error), other(Error)
}
