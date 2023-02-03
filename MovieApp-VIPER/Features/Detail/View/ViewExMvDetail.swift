//
//  ViewEx.swift
//  MovieApp-VIPER
//
//  Created by FauziArda on 03/02/23.
//

import Foundation
import UIKit
import YouTubePlayerKit

extension MovieDetailView{
    func whenNoInternetConnection(){
        // background image placeholder
        self.backgroundImage.image = UIImage(systemName: "photo")
        self.backgroundImage.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.backgroundImage.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        // poster placeholder
        posterImage.tintColor = .white
        
        // genre
        self.movieGenre.text = "No data yet"
        
        // duration
        self.movieDuration.text = "No data yet"
        
        // rate
        self.movieRate.text =  "0 (vote)"
        
        // overview
        self.overviewContent.text = "Can't get the overview content yet. Please check your internet connection first."
        
        // button plat
        self.buttonPlay.setBackgroundImage(UIImage(systemName: "play.slash.fill"), for: .normal)
        self.buttonPlay.isEnabled = false
        
        // set title
        self.movieTitle.text =  "Title"
    }
    
    func setText(_ movieDetail : MovieDetail){ // TODO update content
        // set duration
        self.movieDuration.text = String((movieDetail.runtime)!) + " minutes"
        
        // set rate
        self.movieRate.text = String((movieDetail.voteAverage)!) + " (" + String(movieDetail.voteCount!) + " Vote)"
        
        // set overview
        self.overviewContent.text = movieDetail.overview ?? "overview"
    }
    
    // Function buttonPressed to play trailer video from youtube
    @objc func buttonPressed(){
        let player : YouTubePlayer = YouTubePlayer(
            source: .video(id: self.trailerID), // TODO: change url of video to play (video id)
            configuration: .init(
                autoPlay: true
            )
        )
        
        // Initialize a YouTubePlayerViewController
        let youTubePlayerViewController = YouTubePlayerViewController(
            player: player
        )
        
        // Present YouTubePlayerViewController
        self.present(youTubePlayerViewController, animated: true)

    }
    
    func updateViewContent(_ result: MovieDetail){
        if result.backdropPath == nil  {
            self.backgroundImage.image = UIImage(systemName: "photo")
            self.backgroundImage.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
            self.backgroundImage.heightAnchor.constraint(equalToConstant: 300).isActive = true
        }else{
            self.backgroundImage.load(url: URL(string: imageBaseURL + result.backdropPath!)!)
        }
        
        self.posterImage.load(url: URL(string: imageBaseURL + result.posterPath! )!)
        self.movieTitle.text = result.title

        let comma = ","
        var index = 0
        self.movieGenre.numberOfLines = (result.genres?.count ?? 0 ) > 1 ? 2 : 1
        for genre in result.genres! {
            self.movieGenre.text! += (index > 0 ? comma : "") +  " \(genre.name!)"
            index += 1
        }
        
        self.setText(result)
    }
}

extension MovieDetailView : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count == 0 ? 1 : reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReviewCell.id, for: indexPath) as! ReviewCell
        if self.reviews.count == 0 || self.reviews[indexPath.row].authorDetails?.avatarPath == nil {
            cell.iconImage.image = UIImage(systemName: "person.crop.circle.fill")
        }else{
            cell.iconImage.load(
                url: URL( string: imageBaseURL + (self.reviews[indexPath.row].authorDetails?.avatarPath)!
                          )!
                )
        }
        cell.titleLabel.text = self.reviews.count > 0 ? self.reviews[indexPath.row].author : "No Review Yet"
        cell.descLabel.text = self.reviews.count > 0 ? self.reviews[indexPath.row].content : "No Review Yet"
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Reviews"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if indexPath.row == self.reviews.count - 1 && vm.getConnectionStatus() {
//            vm.setNextPageReview()
//            vm.getMovieReviewsFromAPI(id: self.movieID!){
//                self.reviews.append(contentsOf: self.vm.getReviews())
//                self.tableview.reloadData()
//            }
//        }
    }

    
}
