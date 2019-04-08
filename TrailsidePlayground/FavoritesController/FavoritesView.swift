//
//  FavoritesView.swift
//  TrailsidePlayground
//
//  Created by Yuchen Nie on 4/7/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import UIKit
import SnapKit

class FavoritesView:UIViewController {
    fileprivate var movies:[MovieSearchViewModel] = [MovieSearchViewModel]()
    fileprivate lazy var tableView:UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .white
        tableView.allowsSelection = true
        tableView.register(MovieSearchResultCell.self, forCellReuseIdentifier: MovieSearchResultCell.REUSE_ID)
        self.view.addSubview(tableView)
        return tableView
    }()
    
    override func viewWillLayoutSubviews() {
        tableView.snp.updateConstraints { (make) in
            make.leading.trailing.bottom.equalTo(self.view).priority(999)
            make.bottom.equalTo(self.view).inset(view.safeAreaInsets.bottom)
            make.top.equalTo(self.view)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Favorite Movies"
        edgesForExtendedLayout = []
        loadFavoritedMovies()
    }
    
    private func loadFavoritedMovies() {
        let favoriteMovies = FavoriteMovieCoreDataHelper.instance.loadAllFavoriteMovies()
        movies = favoriteMovies
        tableView.reloadData()
    }
}

extension FavoritesView:UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieSearchResultCell.REUSE_ID, for: indexPath) as? MovieSearchResultCell else {return UITableViewCell()}
        let movieViewModel = movies[indexPath.row]
        cell.configure(with: movieViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let movieViewModel = movies[indexPath.row]
        let detailsView = MovieDetailView()
        MovieDetailConfigurator.instance.configure(with: detailsView, movieViewModel: movieViewModel)
        navigationController?.pushViewController(detailsView, animated: true)
    }
}
