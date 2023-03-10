//
//  ModuleBuilder.swift
//  MovieApp-VIPER
//
//  Created by FauziArda on 03/02/23.
//

import Foundation
import UIKit

// Class Module Builder used for prepare the features
class ModuleBuilder {
    static let shared = ModuleBuilder()
    
    // funtion to prepare ListGenre and Movie List Feature
    func createListGenreAndMoviesViewController() -> ListGenreView {
        let view = ListGenreView()
        let router = ListGenreRouter()
        let interactor = ListGenreInteractor()
        let presenter = ListGenrePresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    // function to prepare the MovieDetail Feature
    func createMovieDetailViewController(_ movieID: Int = 0) -> MovieDetailView {
        let view = MovieDetailView()
        let router = MovieDetailRouter()
        let interactor = MovieDetailInteractor()
        let presenter = MovieDetailPresenter(view: view, interactor: interactor, router: router, currentMovieID: movieID)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.view = view
        
        return view
    }
}
