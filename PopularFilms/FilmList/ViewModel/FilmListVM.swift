//
//  FilmListVM.swift
//  PopularFilms
//
//  Created by Nina on 22.07.2023.
//

import Foundation
import RxSwift

class FilmListVM {
  private weak var view: FilmListVC?
  private weak var router: FilmListRouter?
  private let managerConnections = NetworkManager()

  func bind(view: FilmListVC, router: FilmListRouter) {
    self.view = view
    self.router = router
    self.router?.setSourceView(view)
  }

  func getMoviesList() -> Observable<[Movie]> {
    return managerConnections.getPopularMovies()
  }
  
  func showDetailView(movieId: String) {
    router?.naviagteToDetailView(movieId: movieId)
  }
}
