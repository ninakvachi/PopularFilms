//
//  DetailViewModel.swift
//  PopularFilms
//
//  Created by Nina on 22.07.2023.
//

import Foundation
import RxSwift

class DetailViewModel {
  private var managerConnections = NetworkManager()
  private weak var view: DetailView?
  private weak var router: NavigationDetail?

  func bind(view: DetailView, router: NavigationDetail) {
    self.view = view
    self.router = router
    self.router?.setSourceView(view)
  }

  func getMovieData(movieId: String) -> Observable<MovieDetail> {
    return managerConnections.getDetailMovie(movieId: movieId)
  }
}
