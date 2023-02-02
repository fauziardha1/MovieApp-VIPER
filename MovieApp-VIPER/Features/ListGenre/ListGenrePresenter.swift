//
//  ListGenrePresenter.swift
//  MovieApp-VIPER
//
//  Created by FauziArda on 21/01/23.
//

import Foundation

// contract
// reference to view
// reference to interactor
// reference to router

protocol ListGenrePresenterContract {
//    weak var view : ListGenreViewContract? {get set}
//    weak var interactor : ListGenreInteractorContract? {get set}
//    weak var router : ListGenreRouterContract? {get set}
    
    // on interactor did something
    func interactorDidFetchGenres(with result : Result<[Genre],Error>)
    
    // on interactor did fetch discover movies
    func interactorDidFetchDiscoverMovies(with result: Result<[Movie], Error>)
    
    // action that can triggered by view
    func fetchDiscoverMovie(_ genreID: String)
}

class ListGenrePresenter : ListGenrePresenterContract{
    weak var view : ListGenreViewContract?
    var interactor : ListGenreInteractorContract?{
        didSet{
            interactor?.getGenres()
            interactor?.getDiscoverMovies("")
        }
    }
    var router : ListGenreRouterContract?
    
    func interactorDidFetchGenres(with result: Result<[Genre], Error>) {
        
        switch result {
        case .success(let genres):
            // update view
            self.view?.viewUpdate(with: genres)
        case .failure(let error):
            // update view with error
            self.view?.viewUpdate(with: "Something went wrong \(error.localizedDescription)")
        }
    }
    
    func fetchDiscoverMovie(_ genreID: String = "⋯All"){
        self.interactor?.getDiscoverMovies(genreID == "⋯All" ? "" : genreID)
    }
    
    func interactorDidFetchDiscoverMovies(with result : Result<[Movie],Error>){
        switch result {
        case .success(let movies):
            self.view?.viewUpdateCardMovies(with: movies)
        case .failure(let error):
            self.view?.viewUpdateCardMovies(with: "Something went wrong \(error.localizedDescription)")
        }
    }
    
    
}
