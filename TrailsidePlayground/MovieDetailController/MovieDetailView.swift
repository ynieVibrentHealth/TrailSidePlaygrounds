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
    public var movieDetailsViewModel:MovieSearchViewModel?
    private let favoriteButtonWidth:CGFloat = UIScreen.main.bounds.width - CGFloat(40)
    
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
    fileprivate lazy var rentButtonView:MovieDetailTwoButtonView = MovieDetailTwoButtonView()
    fileprivate lazy var buyButtonView:MovieDetailTwoButtonView = MovieDetailTwoButtonView()
    fileprivate lazy var favoriteButtonView:MovieDetailButtonView = {
        let buttonView = MovieDetailButtonView()
        buttonView.button.accessibilityIdentifier = AutomationConstants.MovieDetailsView.FavoritesButton.rawValue
        buttonView.button.isAccessibilityElement = true
        return buttonView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let movieDetails = movieDetailsViewModel {
            setMovieView(with: movieDetails)
        } else {
            self.showError(with: "Data is missing, please try again later")
        }
    }
    
    override public func viewWillLayoutSubviews() {
        scrollContainer.snp.updateConstraints { (make) in
            make.top.leading.trailing.equalTo(view).priority(999)
            make.bottom.equalTo(view).inset(view.safeAreaInsets.bottom).priority(999)
        }
        
        stackContainer.snp.updateConstraints { (make) in
            make.edges.equalTo(scrollContainer).priority(999)
            make.width.equalTo(view).priority(999)
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
            case .SaveSuccess(let movie):
                self?.saveSuccess(movie: movie)
            }
        }

    }
    
    private func setMovieView(with viewModel:MovieSearchViewModel) {
        title = viewModel.title
        headerView.configure(with: viewModel)
        self.stackContainer.addArrangedSubview(headerView)
        movieDescriptionView.configure(with: viewModel, numberOfLinesLimit: 0)
        self.stackContainer.addArrangedSubview(movieDescriptionView)
        
        rentButtonView.configure(leftButtonTitle: viewModel.rentHD, rightButtonTitle: viewModel.rentSD, leftButtonAction: {
            print("Allow the user to rent movie in HD")
        }) {
            print("Allow the user to rent movie in SD")
        }
        
        stackContainer.addArrangedSubview(rentButtonView)
        
        buyButtonView.configure(leftButtonTitle: viewModel.buyHD, rightButtonTitle: viewModel.buySD, leftButtonAction: {
            print("Allow the user to buy movie in HD")
        }) {
            print("Allow the user to buy movie in SD")
        }
        
        stackContainer.addArrangedSubview(buyButtonView)
        
        
        
        if viewModel.isFavorite {
            favoriteButtonView.configure(buttonTitle: "Already in Favorites", width: favoriteButtonWidth) {}
            favoriteButtonView.disableButton()
        } else {
            favoriteButtonView.configure(buttonTitle: "Add to Favorites", width: favoriteButtonWidth) { [weak self] in
                self?.output?.handle(.SaveFavorite(movie: viewModel))
            }
        }
        

        
        stackContainer.addArrangedSubview(favoriteButtonView)
    }
    
    private func saveSuccess(movie:MovieSearchViewModel) {
        favoriteButtonView.disableButton()
        showError(with: "\(movie.title) added to Favorites!")
        favoriteButtonView.configure(buttonTitle: "Already in Favorites", width: favoriteButtonWidth) {}
    }
}
