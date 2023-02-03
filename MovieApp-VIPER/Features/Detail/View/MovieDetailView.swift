//
//  DetailView.swift
//  MovieApp-VIPER
//
//  Created by FauziArda on 02/02/23.
//

import Foundation
import UIKit

class MovieDetailView : UIViewController{
    var presenter: MovieDetailPresenter?
    var reviews = [Review]()
    var trailerID : String = ""
    
    private lazy var errorLabel : UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        label.numberOfLines = 0
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(errorLabel)
        
        // view
        view.addSubview(label)
        view.addSubview(backgroundImage)
        view.addSubview(titleSection)
        view.addSubview(overviewSection)
        view.addSubview(buttonPlay)
        
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(ReviewCell.self, forCellReuseIdentifier: ReviewCell.id)
        overviewSection.addSubview(tableview)
        
        NSLayoutConstraint.activate([
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            // layouting
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
            buttonPlay.centerXAnchor.constraint(equalTo: backgroundImage.centerXAnchor),
            buttonPlay.centerYAnchor.constraint(equalTo: backgroundImage.centerYAnchor),
            
            titleSection.topAnchor.constraint(equalTo: backgroundImage.bottomAnchor),
            titleSection.leftAnchor.constraint(equalTo: view.leftAnchor),
            titleSection.rightAnchor.constraint(equalTo: view.rightAnchor),
            titleSection.heightAnchor.constraint(equalToConstant: 0),
            
            overviewSection.topAnchor.constraint(equalTo: titleSection.bottomAnchor,constant: 100),
            overviewSection.leftAnchor.constraint(equalTo: titleSection.leftAnchor, constant: 12),
            overviewSection.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 24),
            overviewSection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            tableview.bottomAnchor.constraint(equalTo: overviewSection.bottomAnchor),
            tableview.leftAnchor.constraint(equalTo: overviewSection.leftAnchor),
            tableview.rightAnchor.constraint(equalTo: overviewSection.rightAnchor),
            tableview.topAnchor.constraint(equalTo: overviewContent.bottomAnchor, constant: 12),
        ])
    }
    
    // view component
    lazy var label : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    lazy var backgroundImage : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "photo")
        return imageView
    }()
    
    lazy var posterImage : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.image = UIImage(systemName: "lanyardcard.fill")
        return imageView
    }()
    lazy var movieTitle : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    lazy var movieGenre : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = label.font.withSize(12)
        label.textColor = .systemGray
        label.text = ""
        return label
    }()
    
    lazy var movieGenreLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = label.font.withSize(12)
        label.textColor = .systemGray
        label.text = "Genre\t"
        return label
    }()
    
    lazy var genreHV : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(movieGenreLabel)
        view.addSubview(movieGenre)
        
        NSLayoutConstraint.activate([
            movieGenreLabel.topAnchor.constraint(equalTo: view.topAnchor),
            movieGenreLabel.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            movieGenre.leftAnchor.constraint(equalTo: movieGenreLabel.rightAnchor),
            movieGenre.topAnchor.constraint(equalTo: view.topAnchor),
            movieGenre.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        return view
    }()
    
    lazy var movieDuration : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = label.font.withSize(12)
        label.textColor = .systemGray
        label.text = ""
        return label
    }()
    
    lazy var movieDurationLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = label.font.withSize(12)
        label.textColor = .systemGray
        label.text = "Duration\t"
        return label
    }()
    
    lazy var durationHV : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(movieDurationLabel)
        view.addSubview(movieDuration)
        
        NSLayoutConstraint.activate([
            movieDurationLabel.topAnchor.constraint(equalTo: view.topAnchor),
            movieDurationLabel.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            movieDuration.leftAnchor.constraint(equalTo: movieDurationLabel.rightAnchor),
            movieDuration.topAnchor.constraint(equalTo: view.topAnchor),
            movieDuration.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        return view
    }()
    
    lazy var movieRate : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = label.font.withSize(12)
        label.textColor = .systemGray
        label.text = ""
        return label
    }()
    
    lazy var movieRateLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = label.font.withSize(12)
        label.textColor = .systemGray
        label.text = "Rate\t\t"
        return label
    }()
    
    lazy var rateHV : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(movieRateLabel)
        view.addSubview(movieRate)
        
        NSLayoutConstraint.activate([
            movieRateLabel.topAnchor.constraint(equalTo: view.topAnchor),
            movieRateLabel.leftAnchor.constraint(equalTo: view.leftAnchor),
            movieRate.leftAnchor.constraint(equalTo: movieRateLabel.rightAnchor),
            movieRate.topAnchor.constraint(equalTo: view.topAnchor),
            movieRate.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        return view
    }()
    
    lazy var titleSection : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(posterImage)
        view.addSubview(movieTitle)
        view.addSubview(genreHV)
        view.addSubview(durationHV)
        view.addSubview(rateHV)
        
        NSLayoutConstraint.activate([
            posterImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            posterImage.topAnchor.constraint(equalTo: view.topAnchor, constant: -50),
            posterImage.widthAnchor.constraint(equalToConstant: 100),
            posterImage.heightAnchor.constraint(equalToConstant: 120),
            
            movieTitle.leftAnchor.constraint(equalTo: posterImage.rightAnchor, constant: 12),
            movieTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: -24),
            movieTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12),
            
            genreHV.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 10),
            genreHV.leftAnchor.constraint(equalTo: movieTitle.leftAnchor),
            genreHV.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            genreHV.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 5/9),
            
            durationHV.topAnchor.constraint(equalTo: genreHV.bottomAnchor,constant: 32),
            durationHV.leftAnchor.constraint(equalTo: genreHV.leftAnchor),
            durationHV.rightAnchor.constraint(equalTo: genreHV.rightAnchor),
            
            rateHV.topAnchor.constraint(equalTo: durationHV.bottomAnchor,constant: 16),
            rateHV.leftAnchor.constraint(equalTo: durationHV.leftAnchor),
            rateHV.rightAnchor.constraint(equalTo: durationHV.rightAnchor),
        ])
        
        return view
    }()
    
    lazy var overviewTitle : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Overview"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    lazy var overviewContent : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Overview"
        label.numberOfLines = 0
        label.font = label.font.withSize(16)
        label.textColor = .systemGray
        return label
    }()
    
    // overview section
    lazy var overviewSection : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(overviewTitle)
        view.addSubview(overviewContent)
        view.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            overviewTitle.topAnchor.constraint(equalTo: view.topAnchor),
            overviewTitle.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            overviewContent.topAnchor.constraint(equalTo: overviewTitle.bottomAnchor, constant: 8),
            overviewContent.leftAnchor.constraint(equalTo: overviewTitle.leftAnchor),
            overviewContent.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 24)
        ])
        
        return view
    }()
    
    // tableview instance
    private let tableview : UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .darkGray.withAlphaComponent(0.1)
        return tv
    }()
    
    lazy var buttonPlay : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.setBackgroundImage(UIImage(systemName: "play.circle"), for: .normal)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.tintColor = .white
        return button
    }()
}

extension MovieDetailView : MovieDetailViewContract{
    func viewUpdateMovieTrailer(with result: String) {
        self.trailerID = result
    }
    
    func viewUpdate(with result: MovieDetail) {
        DispatchQueue.main.async {
            self.errorLabel.text = String(describing: result)
            self.errorLabel.isHidden = true
            self.updateViewContent(result)
        }
    }
    
    func viewUpdate(with error: String) {
        DispatchQueue.main.async {
            self.errorLabel.text = error
            self.errorLabel.isHidden = false
            self.whenNoInternetConnection()
        }
    }
    
    func viewUpdateReview(with result: MovieReview) {
        self.reviews = result.results ?? []
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }
    
}
