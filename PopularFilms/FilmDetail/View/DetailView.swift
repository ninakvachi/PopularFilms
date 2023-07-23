//
//  DetailView.swift
//  PopularFilms
//
//  Created by Nina on 22.07.2023.
//
import RxSwift
import UIKit

class DetailView: UIViewController {
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var movieSynopsis: UILabel!
    @IBOutlet var movieReleaseDate: UILabel!
    @IBOutlet var movieImage: UIImageView!
    @IBOutlet var movieHomePage: UILabel!
    @IBOutlet var movieScore: UILabel!
    @IBOutlet var stackviewRound: UIStackView!
    
    
    private var router = NavigationDetail()
    private var viewModel = DetailViewModel()
    private var disposeBag = DisposeBag()

    var movieId: String?
    var movieData: MovieDetail?

    override func viewDidLoad() {
      super.viewDidLoad()
      viewModel.bind(view: self, router: router)
      displayMovieDetail()
      stackviewRound.layer.cornerRadius = 30
      stackviewRound.clipsToBounds = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFunction))

        // Gesture recognizer Label
        movieHomePage.isUserInteractionEnabled = true
        movieHomePage.addGestureRecognizer(tap)

    }

    @objc func tapFunction(sender:UITapGestureRecognizer) {
        guard let url = URL(string: movieData?.homePage ?? "") else { return }
        UIApplication.shared.open(url)
    }
    
    deinit {  }
  }

  extension DetailView {
    private func displayMovieDetail() {
      guard let movieId = movieId else { return }
      return viewModel.getMovieData(movieId: movieId)
        .subscribe(onNext: { [weak self] movie in
          self?.showMovieData(movie: movie)
            self?.movieData = movie
        }, onError: { error in
          print("Error : \(error)")
        }).disposed(by: disposeBag)
    }

    private func showMovieData(movie: MovieDetail) {
      let imageUrl = "https://image.tmdb.org/t/p/w200\(movie.image)"
      DispatchQueue.main.async { [weak self] in
        self?.movieTitle.text = movie.name
        self?.movieSynopsis.text = movie.synopsis
        self?.movieReleaseDate.text = movie.releaseDate
        self?.movieImage.imageFromServerURL(urlString: imageUrl, placeholderImage: UIImage(named: "icons-movie")!)
        self?.movieHomePage.text = movie.homePage
        self?.movieScore.text = String(movie.voteAverage)
      }
    }
  }

