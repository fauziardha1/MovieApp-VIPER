//
//  MovieDetailPresenter.swift
//  MovieApp-VIPER
//
//  Created by FauziArda on 03/02/23.
//

import Foundation

class MovieDetailPresenter : MovieDetailPresenterContract{
    var view: MovieDetailViewContract?
    var interactor: MovieDetailInteractorContract?
    var router: MovieDetailRouterContract?
    
    var currentMovieID: Int?
    
    init(view: MovieDetailViewContract? = nil, interactor: MovieDetailInteractorContract? = nil, router: MovieDetailRouterContract? = nil, currentMovieID: Int? = nil) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.currentMovieID = currentMovieID
        
        self.interactor?.fetchMovieDetail()
        self.interactor?.fetchMovieReviews()
    }
    
    func interactorDidFetchMovieDetail(with result: Result<MovieDetail, Error>) {
        switch result {
        case .success(let movieDetail):
            self.view?.viewUpdate(with: movieDetail)
        case .failure(let error):
            self.view?.viewUpdate(with: "Something went wrong: \(error.localizedDescription)")
        }
    }
    
    func interactorDidFetcMovieReviews(with result: Result<MovieReview, Error>) {
        switch result {
        case .success(let movieReview):
            self.view?.viewUpdateReview(with: movieReview)
        case .failure(let error):
            self.view?.viewUpdate(with: "Something went wrong: \(error.localizedDescription)")
        }
    }
    
    func fetchMovieDetail(_ genreID: String) {
        self.interactor?.fetchMovieDetail()
    }
    
    func fetchMovieReviews(_ movieID: Int) {
        self.interactor?.fetchMovieReviews()
    }
    
    func getCurrentMovieID() -> Int {
        self.currentMovieID ?? 0
    }
    
    
}
