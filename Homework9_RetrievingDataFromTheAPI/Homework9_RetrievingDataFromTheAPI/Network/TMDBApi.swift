//
//  TMDBApi.swift
//  Homework9_RetrievingDataFromTheAPI
//
//  Created by Berkay Emre Aslan on 22.09.2025.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case badStatusCode(Int)
    case decodingFailed
    case missingAPIKey
}

struct TMDBAPI {
    static let base = "https://api.themoviedb.org/3"
    static let imageBase = "https://image.tmdb.org/t/p/w500"

    private static var apiKey: String {
       
        if let key = Bundle.main.object(forInfoDictionaryKey: "TMDB_API_KEY") as? String, !key.isEmpty {
            return key
        }
        return "" 
    }

    private static func makeURL(_ path: String, query: [URLQueryItem] = []) throws -> URL {
        guard var comps = URLComponents(string: base + path) else { throw APIError.invalidURL }
        var items = query
        items.append(URLQueryItem(name: "api_key", value: apiKey))
        items.append(URLQueryItem(name: "language", value: "tr-TR"))
        comps.queryItems = items
        guard let url = comps.url else { throw APIError.invalidURL }
        return url
    }

    static func fetchPopular(page: Int = 1) async throws -> [Movie] {
        guard !apiKey.isEmpty else { throw APIError.missingAPIKey }
        let url = try makeURL("/movie/popular", query: [URLQueryItem(name: "page", value: "\(page)")])
        let (data, resp) = try await URLSession.shared.data(from: url)
        guard (resp as? HTTPURLResponse)?.statusCode == 200 else {
            throw APIError.badStatusCode((resp as? HTTPURLResponse)?.statusCode ?? -1)
        }
        return try JSONDecoder().decode(MovieListResponse.self, from: data).results
    }

    static func searchMovies(_ query: String, page: Int = 1) async throws -> [Movie] {
        guard !apiKey.isEmpty else { throw APIError.missingAPIKey }
        let url = try makeURL("/search/movie", query: [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "include_adult", value: "false"),
            URLQueryItem(name: "page", value: "\(page)")
        ])
        let (data, resp) = try await URLSession.shared.data(from: url)
        guard (resp as? HTTPURLResponse)?.statusCode == 200 else {
            throw APIError.badStatusCode((resp as? HTTPURLResponse)?.statusCode ?? -1)
        }
        return try JSONDecoder().decode(MovieListResponse.self, from: data).results
    }

    static func fetchDetail(id: Int) async throws -> MovieDetail {
        guard !apiKey.isEmpty else { throw APIError.missingAPIKey }
        let url = try makeURL("/movie/\(id)")
        let (data, resp) = try await URLSession.shared.data(from: url)
        guard (resp as? HTTPURLResponse)?.statusCode == 200 else {
            throw APIError.badStatusCode((resp as? HTTPURLResponse)?.statusCode ?? -1)
        }
        return try JSONDecoder().decode(MovieDetail.self, from: data)
    }
}
