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
        tableView.register(FavoriteEmptyView.self, forCellReuseIdentifier: FavoriteEmptyView.REUSE_ID)
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
        if movies.isEmpty {
            return 1
        } else {
            return movies.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if movies.isEmpty {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteEmptyView.REUSE_ID, for: indexPath) as? FavoriteEmptyView else {return UITableViewCell()}
            cell.configure(titleText: "You have no movies favorited.",
                           detailsText: "Please feel free to browse the movies we have available and add them to your favorites!")
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieSearchResultCell.REUSE_ID, for: indexPath) as? MovieSearchResultCell else {return UITableViewCell()}
            let movieViewModel = movies[indexPath.row]
            cell.configure(with: movieViewModel)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard !movies.isEmpty else {return}
        let movieViewModel = movies[indexPath.row]
        let detailsView = MovieDetailView()
        MovieDetailConfigurator.instance.configure(with: detailsView, movieViewModel: movieViewModel)
        navigationController?.pushViewController(detailsView, animated: true)
    }
}
