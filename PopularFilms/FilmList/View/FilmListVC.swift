//
//  FilmListVC.swift
//  PopularFilms
//
//  Created by Nina on 22.07.2023.
//

import RxCocoa
import RxSwift
import UIKit

enum CellKeys: String {
  case nibName = "MovieCell"
  case reuseIdentifier = "Cell"
}

class FilmListVC: UIViewController {
    @IBOutlet var tableView: UITableView!
    private var router = FilmListRouter()
    private var viewModel = FilmListVM()
    private var disposeBag = DisposeBag()
    private var movies = [Movie]()


    override func viewDidLoad() {
      super.viewDidLoad()
      tableView.dataSource = self
      tableView.delegate = self
      configureVC()
      displayMovies()
    }
  }

  extension FilmListVC {
    private func configureVC() {
      configureBindings()
      configureNavBar()
      configureTableView()
    }

    private func configureNavBar() {
      navigationItem.title = "TV Series"
      self.navigationController?.navigationBar.tintColor = UIColor.black
    }

    private func configureTableView() {
      let nibName = CellKeys.nibName.rawValue
      let reuseIdentifier = CellKeys.reuseIdentifier.rawValue
      tableView.rowHeight = UITableView.automaticDimension
      tableView.register(UINib(nibName: nibName, bundle: Bundle.main), forCellReuseIdentifier: reuseIdentifier)
    }

    private func configureBindings() {
      viewModel.bind(view: self, router: router)
    }

  }

  extension FilmListVC {
    private func displayMovies() {
      return viewModel.getMoviesList()
        .subscribe(on: MainScheduler.instance)
        .observe(on: MainScheduler.instance)
        .subscribe(
          onNext: { [weak self] movies in
            self?.movies = movies
            print("movies: \(movies.map { $0.originalTitle })")
            self?.updateTableView()
          }, onError: { error in
            print("error in view: \(error)")
          }, onCompleted: {}).disposed(by: disposeBag)
    }
  }

  extension FilmListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cellIdentifier: String = CellKeys.reuseIdentifier.rawValue
      guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MovieCell else {
        fatalError("Error: \(cellIdentifier)")
      }
     let movie = movies[indexPath.row]
      cell.movie = movie
      return cell
    }
  }

  extension FilmListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 240
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let movie = movies[indexPath.row]
      router.naviagteToDetailView(movieId: String(movie.movieId))
    }
  }

  extension FilmListVC {
    private func updateTableView() {
      DispatchQueue.main.async { [weak self] in
        self?.tableView.reloadData()
      }
    }
  }

