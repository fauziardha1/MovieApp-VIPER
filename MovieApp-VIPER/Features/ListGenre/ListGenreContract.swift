//
//  ListGenreContract.swift
//  MovieApp-VIPER
//
//  Created by FauziArda on 03/02/23.
//

import Foundation
import UIKit

// contract for ListGenre View
// it has reference to presenter
// it has method to update view
// contract
protocol ListGenreViewContract : AnyObject{
    // reference to presenter
//    var presenter : ListGenrePresenterContract? {get set}
    
    // method for updating view
    func viewUpdate(with result : [Genre]) // with data
    func viewUpdate(with error: String) // with error message
    
    func viewUpdateCardMovies(with result: [Movie])
    func viewUpdateCardMovies(with error: String)
}

// contract for interactor
// reference to presenter to trigger presenter when some usecase was done
// set all usecase needed

protocol ListGenreInteractorContract {
    // reference to presenter
//     var presenter : ListGenrePresenterContract? {get set}
    
    // get list of genre
    func getGenres()
    
    // get list of discover movies
    func getDiscoverMovies(_ genreID: String)
}

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
    
    // go to detail
    func goToDetailPage()
    
    var selectedMovieID: Int? {get set}
}

typealias entryView = ListGenreViewContract & UIViewController

// just router
protocol ListGenreRouterContract {
    // navigate to detail page
    func navigateToDetailPage(_ movieID: Int?)
}
