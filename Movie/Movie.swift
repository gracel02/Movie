//
//  Movie.swift
//  Movie
//
//  Created by Grace Liaw on 15/1/22.
//

import Foundation

struct MovieResponse: Decodable {
    let currentPage: Int
    let totalResults: Int?
    let totalPages: Int?
    let results: [Movie]?

    enum CodingKeys: String, CodingKey {
        case currentPage = "page"
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}

struct Movie: Codable, Identifiable {
    let id: Int?
    let title: String?
    let overview: String?
    let backdropPath: String?
    let posterPath: String?
    let popularity: Double?
    let releaseDate: String?
    let voteAverage: Double?
    let voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case popularity
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    var backgroundURL: URL {
        if (backdropPath ?? "").isEmpty {
            return URL(string: "https://fsd.co.id/assets/admin/images/broken-image.png")!
        }else{
            return URL(string: "https://image.tmdb.org/t/p/w500" + backdropPath!)!
        }
    }
    
    var posterURL: URL {
        if (posterPath ?? "").isEmpty {
            return URL(string: "https://fsd.co.id/assets/admin/images/broken-image.png")!
        }else{
            return URL(string: "https://image.tmdb.org/t/p/w500" + posterPath!)!
        }
    }
}

