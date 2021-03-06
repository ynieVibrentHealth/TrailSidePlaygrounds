//
//  MovieSearchView.swift
//  TrailsidePlayground
//
//  Created by Yuchen Nie on 4/7/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import UIKit
import PinLayout
import RxSwift
import RxCocoa

protocol MovieSearchViewInput {
    func display(_ state:MovieSearchModel.Function.State)
}

class MovieSearchView: UIViewController {
    //Configured in the configurator
    public var output:MovieSearchInteractorInput?
    public var router:MovieSearchRouter?
    
    fileprivate let disposeBag:DisposeBag = DisposeBag()
    fileprivate var movies:[MovieSearchViewModel] = [MovieSearchViewModel]()
    private var searchText:String = ""
    
    fileprivate lazy var tableView:UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .white
        tableView.allowsSelection = true
        tableView.register(MovieSearchResulLayouttCell.self, forCellReuseIdentifier: MovieSearchResulLayouttCell.REUSE_ID)
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
    
    fileprivate lazy var favoriteMoviesButton:UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = "Favorites"
        button.rx.tap.subscribe(onNext: { [weak self] (_) in
            self?.router?.navigate(to: .FavoriteMovies)
        }).disposed(by: self.disposeBag)
        button.isAccessibilityElement = true
        return button
    }()
    
    fileprivate lazy var loadingIndicator:LoadingIndicator = {
        let loading = LoadingIndicator()
        loading.loadActivity()
        loading.isHidden = true
        self.view.addSubview(loading)
        return loading
    }()
    
    ///After user enteres their search term, the observable will send off a request after a predetermined period of inactivity
    fileprivate lazy var searchMovieObservable:PublishSubject<Bool> = {
        let observable:PublishSubject<Bool> = PublishSubject<Bool>()
        let timeInterval = RxTimeInterval.milliseconds(500)
        observable
            .debounce(timeInterval, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] (_) in
                guard let _self = self,
                    !_self.searchText.isEmpty else {return}
                _self.output?.handle(.SearchMovie(searchTerm: _self.searchText))
            }).disposed(by: self.disposeBag)
        return observable
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Search iTunes Movies"
        navigationItem.rightBarButtonItem = favoriteMoviesButton
        edgesForExtendedLayout = []
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchMovieObservable.onNext(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchbar.text = "ju"
        self.searchText = "ju"
        searchMovieObservable.onNext(true)
    }
    
    override func viewDidLayoutSubviews() {
        searchbar.pin.top().left().right().height(50)
        tableView.pin.below(of: searchbar, aligned: .center).width(of: self.view).bottom()
        loadingIndicator.pin.all()
        super.viewDidLayoutSubviews()
    }
    
    private func refresh() {
        self.searchbar.text = ""
        searchText = ""
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieSearchResulLayouttCell.REUSE_ID, for: indexPath) as? MovieSearchResulLayouttCell else {return UITableViewCell()}
        let movieViewModel = movies[indexPath.row]
        cell.configure(with: movieViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let movieViewModel = movies[indexPath.row]
        router?.navigate(to: .MovieDetails(movieViewModel: movieViewModel))
    }
}


extension MovieSearchView:UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        loadingIndicator.isHidden = false
        view.bringSubviewToFront(loadingIndicator)
        self.searchText = searchText
        searchMovieObservable.onNext(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        refresh()
    }
}

