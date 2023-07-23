//
//  NavigationDetail.swift
//  PopularFilms
//
//  Created by Nina on 22.07.2023.
//

import UIKit

class NavigationDetail {
  private weak var sourceView: UIViewController?
  var movieId: String?

  init(movieId: String = "") {
    self.movieId = movieId
  }
}

extension NavigationDetail {
  func setSourceView(_ sourceView: UIViewController?) {
    guard let view = sourceView else { return }
    self.sourceView = view
  }

  func createViewController(movieId: String) -> UIViewController {
    let vc = DetailView(nibName: "DetailView", bundle: Bundle.main)
    vc.movieId = movieId
    return vc
  }
}
