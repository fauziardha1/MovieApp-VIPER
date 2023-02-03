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
        
        self.interactor?.fetchMovieDetail(currentMovieID!)
        self.interactor?.fetchMovieReviews(currentMovieID!)
        self.interactor?.fetchMovieTrailer(currentMovieID!)
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
    
    func interactorDidFetchMovieTrailer(with result: Result<MovieVideo, Error>) {
        switch result{
        case .success(let data):
            var key : String = ""
            for movie in data.results! {
                if movie.type == "Trailer"{
                    key = movie.key!
                    break
                }
            }
            self.view?.viewUpdateMovieTrailer(with: key)
            
        case .failure(let error):
            self.view?.viewUpdate(with: "Something went wrong: \(error.localizedDescription)")
        }
    }
    
    func fetchMovieTrailer(_ movieID: Int) {
        self.interactor?.fetchMovieTrailer(movieID)
    }
    
    func fetchMovieDetail(_ movieID: String) {
        self.interactor?.fetchMovieDetail(Int(movieID) ?? self.currentMovieID!)
    }
    
    func fetchMovieReviews(_ movieID: Int) {
        self.interactor?.fetchMovieReviews(movieID)
    }
    
    
    
}
