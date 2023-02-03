//
//  MovieDetailContract.swift
//  MovieApp-VIPER
//
//  Created by FauziArda on 03/02/23.
//

import Foundation

protocol MovieDetailViewContract {
    // function to update detail information of current movie
    func viewUpdate(with result: MovieDetail)
    
    // function to shows error message when there is a mistake was happen
    func viewUpdate(with error: String)
    
    // function to update reviews list of the movie
    func viewUpdateReview(with result: MovieReview)
    
    // function to get movie trailer url
    func viewUpdateMovieTrailer(with result: String)
}

protocol MovieDetailInteractorContract {
    // function to get movie detail
    func fetchMovieDetail(_ movieID: Int)
    
    // function to get movie reviews
    func fetchMovieReviews(_ movieID: Int)
    
    // function to get movie trailer
    func fetchMovieTrailer(_ movieID: Int)
}

protocol MovieDetailPresenterContract {
    // on interactor did something
    func interactorDidFetchMovieDetail(with result : Result<MovieDetail,Error>)
    
    // on interactor did fetch discover movies
    func interactorDidFetcMovieReviews(with result: Result<MovieReview, Error>)
    
    // when interactor did fetch movie's trailer
    func interactorDidFetchMovieTrailer(with result: Result<MovieVideo, Error>)
    
    // action that can triggered by view
    func fetchMovieDetail(_ genreID: String)
    
    // function to get movies reviews
    func fetchMovieReviews(_ movieID: Int)
    
    // function to get movie trailer
    func fetchMovieTrailer(_ movieID: Int)
}

//  router contract to navigate the current view
protocol MovieDetailRouterContract {
}
