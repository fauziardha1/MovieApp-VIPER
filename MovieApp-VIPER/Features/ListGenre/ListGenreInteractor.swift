//
//  ListGenreInteractor.swift
//  MovieApp-VIPER
//
//  Created by FauziArda on 21/01/23.
//

import Foundation

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

class ListGenreInteractor : ListGenreInteractorContract{
    var presenter: ListGenrePresenterContract?
    
    func getGenres() {
        let genresURL = "https://api.themoviedb.org/3/genre/movie/list?api_key=4e0be2c22f7268edffde97481d49064a&language=en-US"
        guard let url = URL(string: genresURL) else {return}
        
        let task = URLSession.shared.dataTask(with: url){ [weak self] data, _, error in
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidFetchGenres(with: .failure(error!))
                return
            }
            
            do {
                let entities = try JSONDecoder().decode(Genres.self, from: data)
                self?.presenter?.interactorDidFetchGenres(with: .success(entities.genres))
//                return
            } catch {
                self?.presenter?.interactorDidFetchGenres(with: .failure(error))
//                return
            }
            
        }
        task.resume()
        
    }
    
    func getDiscoverMovies(_ genreID: String = "")  {
        let moviesURL = "https://api.themoviedb.org/3/discover/movie?api_key=c410263697615899edf2bdf7903a1a05&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=\(genreID)&with_watch_monetization_types=flatrate"
        
        guard let url = URL(string: moviesURL) else {return}
        
        let task = URLSession.shared.dataTask(with: url){[weak self] data,_,error in
            guard let data = data, error == nil else{
                self?.presenter?.interactorDidFetchDiscoverMovies(with: .failure(error!))
                return
            }
            
            do {
                let entities = try JSONDecoder().decode(DiscoverMovies.self, from: data)
                self?.presenter?.interactorDidFetchDiscoverMovies(with: .success(entities.results))
                
            } catch {
                self?.presenter?.interactorDidFetchDiscoverMovies(with: .failure(error))
            }
        }
        task.resume()
    }
    
    
}
