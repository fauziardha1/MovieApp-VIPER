//
//  MovieDetailContract.swift
//  MovieApp-VIPER
//
//  Created by FauziArda on 03/02/23.
//

import Foundation

protocol MovieDetailViewContract {
//    var presenter : MovieDetailPresenter? {get set}
    
    func viewUpdate(with result: MovieDetail)
    func viewUpdate(with error: String)
    
    func viewUpdateReview(with result: MovieReview)
}

protocol MovieDetailInteractorContract {
    func fetchMovieDetail()
    func fetchMovieReviews()
}

protocol MovieDetailPresenterContract {
//    weak var view : ListGenreViewContract? {get set}
//    weak var interactor : ListGenreInteractorContract? {get set}
//    weak var router : ListGenreRouterContract? {get set}
    
    // on interactor did something
    func interactorDidFetchMovieDetail(with result : Result<MovieDetail,Error>)
    
    // on interactor did fetch discover movies
    func interactorDidFetcMovieReviews(with result: Result<MovieReview, Error>)
    
    // action that can triggered by view
    func fetchMovieDetail(_ genreID: String)
    
    //
    func fetchMovieReviews(_ movieID: Int)
    
    // get currentmovieid
    func getCurrentMovieID() -> Int
}

// just router
protocol MovieDetailRouterContract {
    // navigate to detail page
//    func navigateToDetailPage()
}
