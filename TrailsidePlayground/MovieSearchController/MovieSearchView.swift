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
import RxCocoa

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
        tableView.separatorStyle = .singleLine
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
        self.view.addSubview(searchbar)
        return searchbar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewWillLayoutSubviews() {
        searchbar.snp.updateConstraints { (make) in
            make.top.leading.trailing.equalTo(self.view)
            make.height.equalTo(50)
        }
        
        tableView.snp.updateConstraints { (make) in
            make.leading.trailing.bottom.equalTo(self.view)
            make.top.equalTo(searchbar.snp.bottom)
        }
    }
    
    private func refresh() {
        
    }
}

extension MovieSearchView: MovieSearchViewInput {
    
    
    func display(_ state: MovieSearchModel.Function.State) {
        
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
           output?.handle(.SearchMovie(searchTerm: searchText))
        } else {
            refresh()
        }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        refresh()
        tableView.reloadData()
    }
}
