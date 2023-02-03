//
//  ListGenreContract.swift
//  MovieApp-VIPER
//
//  Created by FauziArda on 03/02/23.
//

import Foundation
import UIKit

// view contract is a contract for a view to get updated data from other layers
protocol ListGenreViewContract : AnyObject{
    // method for updating view
    func viewUpdate(with result : [Genre]) // with data
    func viewUpdate(with error: String) // with error message
    
    // function to udpate movie's cards when success
    func viewUpdateCardMovies(with result: [Movie])
    
    // function to udpate movie's cards when success
    func viewUpdateCardMovies(with error: String)
    
    // function to append data to movie's card, so its like endless scrolling
    func viewApppendCardMovies(with result: [Movie])
}

// interactor contract is a contract for interaction to outside the app
protocol ListGenreInteractorContract {
    // get list of genre
    func getGenres()
    
    // get list of discover movies
    func getDiscoverMovies(_ genreID: String)
    
    // function to load more movies
    func loadMoreDiscoverMovies(_ genreID: String, _ page: Int)
}

// presenter contract as center of controll from the feature
protocol ListGenrePresenterContract {
    // on interactor did something
    func interactorDidFetchGenres(with result : Result<[Genre],Error>)
    
    // on interactor did fetch discover movies
    func interactorDidFetchDiscoverMovies(with result: Result<[Movie], Error>)
    
    // action that can triggered by view
    func fetchDiscoverMovie(_ genreID: String)
    
    // go to detail
    func goToDetailPage()
    
    var selectedMovieID: Int? {get set}
    
    // function to append movies card
    func loadMoreDiscoverMovie(_ genreID: String, _ page: Int)
    
    // function to trigger when success load more discover movie
    func interactorDidLoadMoreDiscoverMovies(with result: Result<[Movie], Error>)
}

//  router contract to navigate this page to other page
protocol ListGenreRouterContract {
    // navigate to detail page
    func navigateToDetailPage(_ movieID: Int?)
}
