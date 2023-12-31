//
//  Extensions.swift
//  PopularFilms
//
//  Created by Nina on 22.07.2023.
//

import UIKit.UIImage
import UIKit.UIImageView

extension UIImageView {
  func imageFromServerURL(urlString: String, placeholderImage: UIImage) {
    guard let url = URL(string: urlString) else { return }

    URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
      guard error == nil else {
        self?.image = placeholderImage
        return
      }
      guard let data = data else { return }
      DispatchQueue.main.async {
        self?.image = UIImage(data: data)
      }
    }.resume()
  }
}
