//
//  MovieDetailInteractor.swift
//  MovieApp-VIPER
//
//  Created by FauziArda on 03/02/23.
//

import Foundation


class MovieDetailInteractor : MovieDetailInteractorContract{
    var presenter: MovieDetailPresenterContract?
    
    func fetchMovieDetail() {
        let id = self.presenter?.getCurrentMovieID()
        let mvDetailURL = "https://api.themoviedb.org/3/movie/\(id ?? 0)?api_key=4e0be2c22f7268edffde97481d49064a&language=en-US"
        guard let url = URL(string: mvDetailURL) else {return}
        
        let task = URLSession.shared.dataTask(with: url){ [weak self] data,_,error in
            guard let data = data, error == nil else{
                self?.presenter?.interactorDidFetchMovieDetail(with: .failure(error!))
                return
            }
            
            do{
                let entity = try JSONDecoder().decode(MovieDetail.self, from: data)
                self?.presenter?.interactorDidFetchMovieDetail(with: .success(entity))
            } catch {
                print(error)
                self?.presenter?.interactorDidFetchMovieDetail(with: .failure(error))
            }
            
        }
        task.resume()
    }
    
    func fetchMovieReviews() {
        let id = self.presenter?.getCurrentMovieID()
        let mvrURL = "https://api.themoviedb.org/3/movie/\(id ?? 0)/reviews?api_key=4e0be2c22f7268edffde97481d49064a&language=en-US&page=1"
        
        guard let url = URL(string: mvrURL) else {return}
        
        let task = URLSession.shared.dataTask(with: url){ [weak self] data,_,error in
            guard let data = data, error == nil else{
                self?.presenter?.interactorDidFetcMovieReviews(with: .failure(error!))
                return
            }
            
            do{
                let entity = try JSONDecoder().decode(MovieReview.self, from: data)
                self?.presenter?.interactorDidFetcMovieReviews(with: .success(entity))
            }catch{
                print(error)
                self?.presenter?.interactorDidFetcMovieReviews(with: .failure(error))
            }
            
        }
        task.resume()
    }
    
    
}
