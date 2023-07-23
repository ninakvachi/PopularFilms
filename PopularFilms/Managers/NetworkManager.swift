//
//  NetworkManager.swift
//  PopularFilms
//
//  Created by Nina on 22.07.2023.
//

import Foundation
import RxSwift

class NetworkManager {

  func getPopularMovies() -> Observable<[Movie]> {
    return Observable.create { observer in
      NetworkRequest.makeNetworkRequest(path: "/3/tv/popular") { (completion: RequestCompletionType<Movies>) in
        switch completion {
          case .requestSuccessful(data: let data):
            observer.onNext(data.moviesList)
          case .requestEnded:
            observer.onCompleted()
          case .requestFailure(let error):
            observer.onError(error)
        }
      }
      return Disposables.create()
    }
  }

  func getDetailMovie(movieId: String) -> Observable<MovieDetail> {
    let path: String = "/3/tv/\(movieId)"
    return Observable.create { observer in
      NetworkRequest.makeNetworkRequest(path: path) { (completion: RequestCompletionType<MovieDetail>) in
        switch completion {
          case .requestSuccessful(data: let data):
            observer.onNext(data)
          case .requestEnded:
            observer.onCompleted()
          case .requestFailure(let error):
            observer.onError(error)
        }
      }
      return Disposables.create()
    }
  }
}
