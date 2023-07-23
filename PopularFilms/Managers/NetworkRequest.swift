//
//  NetworkRequest.swift
//  PopularFilms
//
//  Created by Nina on 22.07.2023.
//

import Foundation

enum RequestCompletionType<T> {
  case requestSuccessful(data: T)
  case requestFailure(error: Error)
  case requestEnded
}
//

enum NetworkRequest {
  static func makeNetworkRequest<T: Decodable>(path: String, requestCompleted: @escaping (RequestCompletionType<T>) -> Void) {

    var urlBuilder = URLComponents()
    urlBuilder.scheme = "https"
    urlBuilder.host = "api.themoviedb.org"
    urlBuilder.path = path
    urlBuilder.queryItems = [
      URLQueryItem(name: "api_key", value: Keys.apiKey)
    ]
      print("FETCH FROM: \(String(describing: urlBuilder.url))")
    guard let url = urlBuilder.url else {
      fatalError("failed to decode url: \(urlBuilder.string ?? "")")
    }


    let session = URLSession.shared
    session.dataTask(with: url) { data, response, error in
      guard let data = data, let response = response as? HTTPURLResponse, error == nil else { return }
      guard response.statusCode == 200 else {
        print("Error, response code is NOT 200")
        return
      }
      do {
        let data = try JSONDecoder().decode(T.self, from: data)
        requestCompleted(.requestSuccessful(data: data))
      } catch {
        requestCompleted(.requestFailure(error: error))
        print("Error decoding: \(error)")
      }
      requestCompleted(.requestEnded)
    }.resume()
    session.finishTasksAndInvalidate()
  }
}
