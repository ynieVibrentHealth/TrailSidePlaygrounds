//
//  MovieSearchView.swift
//  TrailsidePlayground
//
//  Created by Yuchen Nie on 4/7/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift

protocol MovieSearchViewInput {
    func display(_ state:MovieSearchModel.Function.State)
}

class MovieSearchView: UIViewController {
    //Configured in the configurator
    public var output:MovieSearchInteractorInput?
    public var router:MovieSearchRouter?
    
    fileprivate lazy var disposeBag:DisposeBag = DisposeBag()
    fileprivate var movies:[MovieSearchViewModel] = [MovieSearchViewModel]()
    
    fileprivate lazy var tableView:UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .white
        tableView.allowsSelection = false
        tableView.register(MovieSearchResultCell.self, forCellReuseIdentifier: MovieSearchResultCell.REUSE_ID)
        self.view.addSubview(tableView)
        return tableView
    }()
    
    fileprivate lazy var searchbar:UISearchBar = {
        let searchbar:UISearchBar = UISearchBar(frame: .zero)
        searchbar.delegate = self
        searchbar.autocorrectionType = .no
        searchbar.autocapitalizationType = .none
        searchbar.showsCancelButton = true
        searchbar.placeholder = "Search for a movie!"
        self.view.addSubview(searchbar)
        return searchbar
    }()
    
    fileprivate lazy var loadingIndicator:LoadingIndicator = {
        let loading = LoadingIndicator()
        loading.loadActivity()
        loading.isHidden = true
        self.view.addSubview(loading)
        return loading
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Search iTunes Movies"
        edgesForExtendedLayout = []
    }
    
    override func viewWillLayoutSubviews() {
        searchbar.snp.updateConstraints { (make) in
            make.top.leading.trailing.equalTo(self.view)
            make.height.equalTo(50)
        }
        
        tableView.snp.updateConstraints { (make) in
            make.leading.trailing.bottom.equalTo(self.view).priority(999)
            make.bottom.equalTo(self.view).inset(view.safeAreaInsets.bottom)
            make.top.equalTo(searchbar.snp.bottom)
        }
        
        loadingIndicator.snp.updateConstraints { (make) in
            make.edges.equalTo(tableView).priority(999)
        }
    }
    
    private func refresh() {
        self.searchbar.text = ""
        self.loadingIndicator.isHidden = true
        movies = []
        tableView.reloadData()
    }
}

extension MovieSearchView: MovieSearchViewInput, ViewControllerShowsError {
    func display(_ state: MovieSearchModel.Function.State) {
        DispatchQueue.main.async { [weak self] in
            self?.loadingIndicator.isHidden = true
            switch state {
            case .MovieResults(let movies):
                self?.movies = movies
                self?.tableView.reloadData()
            case .Error(let errorString):
                self?.showError(with: errorString)
            }
        }
        
    }
}

extension MovieSearchView:UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieSearchResultCell.REUSE_ID, for: indexPath) as? MovieSearchResultCell else {return UITableViewCell()}
        let movie = movies[indexPath.row]
        cell.configure(with: movie)
        return cell
    }
}


extension MovieSearchView:UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            self.loadingIndicator.isHidden = false
            view.bringSubviewToFront(loadingIndicator)
            output?.handle(.SearchMovie(searchTerm: searchText))
        } else {
            refresh()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        refresh()
    }
}

