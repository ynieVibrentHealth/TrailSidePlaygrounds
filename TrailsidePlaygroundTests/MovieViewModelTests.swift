//
//  MovieViewModelTests
//  TrailsidePlaygroundTests
//
//  Created by Yuchen Nie on 4/6/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import XCTest
import Quick
import Nimble

@testable import TrailsidePlayground

class MovieViewModelTests: QuickSpec {

    override func spec() {
        describe("Testing for View Model generator from DTOs") {
            let interactor = MockSearchInteractor()
            let presenter = MovieSearchPresenter()
            let view = MockSearchView()
            
            interactor.output = presenter
            presenter.output = view
            
            context("Data parsing test", {
                it("Should load movie search model from search term", closure: {
                    interactor.handle(.SearchMovie(searchTerm: "jurassic"))
                    let movies = view.movies
                    let errorString = view.errorString
                    expect(movies.count == 11).to(beTrue())
                    expect(errorString.isEmpty).to(beTrue())
                    
                    guard let firstMovie = movies.first else {
                        fail("Couldn't locate first movie");return
                    }
                    expect(firstMovie.title == "Jurassic Park").to(beTrue())
                    expect(firstMovie.buyHD == "Buy HD $7.99").to(beTrue())
                    expect(firstMovie.buySD == "Buy $7.99").to(beTrue())
                    expect(firstMovie.contentInformation == "PG-13, 126 minutes").to(beTrue())
                    expect(firstMovie.director == "Steven Spielberg").to(beTrue())
                    expect(firstMovie.description.isEmpty).to(beFalse())
                    expect(firstMovie.year == "Released: Jun 11, 1993").to(beTrue())
                    expect(firstMovie.imageURLString.isEmpty).to(beFalse())
                    expect(firstMovie.rentHD == "Rent HD $3.99").to(beTrue())
                    expect(firstMovie.rentSD == "Rent $3.99").to(beTrue())
                })
            })
            
            context("Error Loading Test", {
                it("Should load an error message", closure: {
                    interactor.handle(.SearchMovie(searchTerm: "Unable to find movie"))
                    let movies = view.movies
                    let errorString = view.errorString
                    
                    expect(movies.isEmpty).to(beTrue())
                    expect(errorString == "We were unable to retrieve the data, please try again later!").to(beTrue())
                })
            })
        }
    }
    
    class MockSearchInteractor:MovieSearchInteractorInput {
        public var output:MovieSearchPresenterInput?
        
        func handle(_ request: MovieSearchModel.Function.Request) {
            switch request {
            case .SearchMovie(let searchTerm):
                loadMoviesDTO(from: searchTerm)
            }
        }
        
        private func loadMoviesDTO(from searchTerm:String) {
            if searchTerm == "jurassic" {
                guard let mockData:MovieSearchResultDTO = TestHelper.readJSONObject(from: "JurassicMock") else {
                    output?.process(.SearchError(error: .CorruptedData))
                    return
                }
                output?.process(.ProcessMovies(movieResultDTO: mockData))
            } else {
                output?.process(.SearchError(error: .UnableToRetrieveData))
            }
        }
    }
    
    class MockSearchView:MovieSearchViewInput {
        public var movies:[MovieSearchViewModel] = []
        public var errorString:String = ""
        
        func display(_ state: MovieSearchModel.Function.State) {
            switch state {
            case .MovieResults(let movies):
                self.movies = movies
                self.errorString = ""
            case .Error(let errorString):
                self.errorString = errorString
                self.movies = []
            }
        }
    }

}
