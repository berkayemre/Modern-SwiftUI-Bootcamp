//
//  Movie.swift
//  Homework9_RetrievingDataFromTheAPI
//
//  Created by Berkay Emre Aslan on 22.09.2025.
//

import Foundation

struct MovieListResponse: Codable {
    let page: Int
    let results: [Movie]
}

struct Movie: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    let overview: String?
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String?
    let voteAverage: Double?

    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}

struct MovieDetail: Codable, Identifiable {
    let id: Int
    let title: String
    let overview: String?
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String?
    let voteAverage: Double?
    let runtime: Int?
    let genres: [Genre]?

    enum CodingKeys: String, CodingKey {
        case id, title, overview, runtime, genres
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}

struct Genre: Codable, Identifiable {
    let id: Int
    let name: String
}

let mockMovie = Movie(
        id: 1,
        title: "Inception",
        overview: "Rüyalar içinde rüyalar...",
        posterPath: "/qmDpIHrmpJINaRKAfWQfftjCdyi.jpg",
        backdropPath: "/s3TBrRGB1iav7gFOCNx3H31MoES.jpg",
        releaseDate: "2010-07-16",
        voteAverage: 8.4
    )
