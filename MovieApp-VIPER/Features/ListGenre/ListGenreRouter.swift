//
//  ListGenreRouter.swift
//  MovieApp-VIPER
//
//  Created by FauziArda on 21/01/23.
//

import Foundation
import UIKit

typealias entryView = ListGenreViewContract & UIViewController

// just router
protocol ListGenreRouterContract {
    static func start() -> ListGenreRouterContract
    
    // entry
    var entry : entryView? {get}
}

class ListGenreRouter : ListGenreRouterContract{
     var entry : entryView?
    
    static func start() -> ListGenreRouterContract {
        let router = ListGenreRouter()
        let view = ListGenreView()
        let interactor = ListGenreInteractor()
        let presenter = ListGenrePresenter()
        
        presenter.interactor = interactor
        presenter.router = router
        
        view.presenter = presenter
        presenter.view = view
        
        interactor.presenter = presenter
        
        router.entry = view as? entryView
        
        return router
    }
    
    
}
