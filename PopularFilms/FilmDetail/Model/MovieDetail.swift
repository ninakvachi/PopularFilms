//
//  MovieDetail.swift
//  PopularFilms
//
//  Created by Nina on 22.07.2023.
//

import Foundation

struct MovieDetail: Decodable {
  let name: String
  let image: String
  let synopsis: String
  let releaseDate: String
  let homePage: String
  let voteAverage: Double

  enum CodingKeys: String, CodingKey {
    case name
    case image = "backdrop_path"
    case synopsis = "overview"
    case releaseDate = "first_air_date"
    case homePage = "homepage"
    case voteAverage = "vote_average"
  }
}
