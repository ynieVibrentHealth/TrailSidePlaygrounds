//
//  MovieDetailView.swift
//  TrailsidePlayground
//
//  Created by Yuchen Nie on 4/7/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import UIKit
import SnapKit

protocol MovieDetailViewInput {
    func display(_ state:MovieDetailModel.Function.State)
}

class MovieDetailView:UIViewController, ViewControllerShowsError {
    public var output:MovieDetailInteractorInput?
    public var movieId:Int?
    public var movieDetailsViewModel:MovieSearchViewModel?
    
    fileprivate lazy var stackContainer:UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        self.scrollContainer.addSubview(stack)
        return stack
    }()
    
    fileprivate lazy var scrollContainer:UIScrollView = {
        let scroll = UIScrollView()
        self.view.addSubview(scroll)
        return scroll
    }()
    
    fileprivate lazy var headerView:MovieContentView = MovieContentView()
    fileprivate lazy var movieDescriptionView:MovieDescriptionView = MovieDescriptionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let movieDetails = movieDetailsViewModel {
            setMovieView(with: movieDetails)
        } else if let movieId = movieId {
            output?.handle(.MovieDetails(movieId: "\(movieId)"))
        } else {
            self.showError(with: "Data is missing, please try again later")
        }
    }
    
    override public func viewWillLayoutSubviews() {
        scrollContainer.snp.updateConstraints { (make) in
            make.top.leading.trailing.equalTo(view)
            make.bottom.equalTo(view).inset(view.safeAreaInsets.bottom)
        }
        
        stackContainer.snp.updateConstraints { (make) in
            make.edges.equalTo(scrollContainer)
            make.width.equalTo(view)
        }
        super.viewWillLayoutSubviews()
    }
}

extension MovieDetailView:MovieDetailViewInput {
    func display(_ state: MovieDetailModel.Function.State) {
        DispatchQueue.main.async { [weak self] in
            switch state {
            case .MovieDetails(let movieDetails):
                self?.setMovieView(with: movieDetails)
            case .Error(let errorString):
                self?.showError(with: errorString)
            }
        }

    }
    
    private func setMovieView(with viewModel:MovieSearchViewModel) {
        title = viewModel.title
        headerView.configure(with: viewModel)
        self.stackContainer.addArrangedSubview(headerView)
        movieDescriptionView.configure(with: viewModel, numberOfLinesLimit: 0)
        self.stackContainer.addArrangedSubview(movieDescriptionView)
    }
}
