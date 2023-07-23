//
//  FilmListRouter.swift
//  PopularFilms
//
//  Created by Nina on 22.07.2023.
//

import UIKit

class FilmListRouter {
  private weak var sourceView: UIViewController?
}

extension FilmListRouter {
  func setSourceView(_ sourceView: UIViewController?) {
    guard let view = sourceView else { fatalError("Error") }
    self.sourceView = view
  }

  func naviagteToDetailView(movieId: String) {
    let detailView = NavigationDetail(movieId: movieId).createViewController(movieId: movieId)
    sourceView?.navigationController?.pushViewController(detailView, animated: true)
  }
}
