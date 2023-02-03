//
//  ListGenreRouter.swift
//  MovieApp-VIPER
//
//  Created by FauziArda on 21/01/23.
//

import Foundation
import UIKit

class ListGenreRouter : ListGenreRouterContract{
    
    weak var viewController : ListGenreView?
    
    func navigateToDetailPage(_ movieID: Int? = 0) {
        print("masuk ke router")
        let detailPage = ModuleBuilder.shared.createMovieDetailViewController(movieID!)
        self.viewController?.navigationController?.pushViewController(detailPage, animated: true)
    }
    
}
