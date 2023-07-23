//
//  Movies.swift
//  PopularFilms
//
//  Created by Nina on 22.07.2023.
//

import Foundation

struct Movies: Decodable {
  let moviesList: [Movie]

  enum CodingKeys: String, CodingKey {
    case moviesList = "results"
  }
}

struct Movie: Decodable {
  let name: String
  let popularity: Double
  let movieId: Int
  let voteCount: Int
  let originalTitle: String
  let voteAverage: Double
  let synopsis: String
  let releaseDate: String
  let image: String

  enum CodingKeys: String, CodingKey {
    case movieId = "id"
    case voteCount = "vote_count"
    case originalTitle = "original_name"
    case voteAverage = "vote_average"
    case synopsis = "overview"
    case releaseDate = "first_air_date"
    case image = "backdrop_path"
    case name, popularity
  }
}
