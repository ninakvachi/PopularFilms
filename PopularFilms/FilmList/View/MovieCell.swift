//
//  MovieCell.swift
//  PopularFilms
//
//  Created by Nina on 22.07.2023.
//


import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet var viewRound: UIView!
    @IBOutlet var movieImage: UIImageView!
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var movieSynopsis: UILabel!
    
    var movie: Movie? {
      didSet {
        configureCell()
      }
    }

    override func awakeFromNib() {
      super.awakeFromNib()
    }

  }

  extension MovieCell {
    private func configureCell() {
      guard let movie = self.movie else { return }
      let imageUrl = "https://image.tmdb.org/t/p/w200\(movie.image)"
      movieTitle.text = "Name: " + movie.name
        movieSynopsis.text =  "Score: \(movie.voteAverage)"
      movieImage.imageFromServerURL(urlString: imageUrl, placeholderImage: UIImage(named: "icons-movie")!)
        movieImage?.layer.cornerRadius = 15
        movieImage.clipsToBounds = true
        viewRound?.layer.cornerRadius = 15
        viewRound.clipsToBounds = true
    }
  }
