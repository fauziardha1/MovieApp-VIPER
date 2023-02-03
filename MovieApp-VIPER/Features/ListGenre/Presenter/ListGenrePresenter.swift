//
//  ListGenrePresenter.swift
//  MovieApp-VIPER
//
//  Created by FauziArda on 21/01/23.
//

import Foundation

class ListGenrePresenter : ListGenrePresenterContract{
    weak var view : ListGenreViewContract?
    var interactor : ListGenreInteractorContract?
    var router : ListGenreRouterContract?
    
    var selectedMovieID: Int?
    
    init(view: ListGenreViewContract? = nil, interactor: ListGenreInteractorContract? = nil, router: ListGenreRouterContract? = nil) {
        self.view = view
        self.interactor = interactor
        self.router = router
        
        self.interactor?.getGenres()
        self.interactor?.getDiscoverMovies("")
    }
    
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
    
    func goToDetailPage() {
        self.router?.navigateToDetailPage(self.selectedMovieID)
    }
    
}
