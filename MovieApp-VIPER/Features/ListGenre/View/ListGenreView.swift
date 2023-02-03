//
//  ListGenreView.swift
//  MovieApp-VIPER
//
//  Created by FauziArda on 21/01/23.
//

import Foundation
import UIKit

class ListGenreView : UIViewController, ListGenreViewContract{
    var presenter : ListGenrePresenterContract?
    private var selectedGenre = "⋯All"
    private var genres = [Genre]()
    private var movies = [Movie]()
    
    private lazy var stackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.spacing = 12
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
    
    private lazy var uiScrollView : UIScrollView = {
        let us = UIScrollView()
        us.translatesAutoresizingMaskIntoConstraints = false
        return us
    }()
    
    private lazy var textError : UILabel =  {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.numberOfLines = 0
        label.textColor = .white
        label.isHidden = true
        
        return label
    }()
    
    func addButtonToScrollView(_ genres : [Genre] = []){
        // remove all button
        for view in stackView.subviews{
            view.removeFromSuperview()
        }
        // add to stackview
        var genreList = [Genre(id: 0, name: "⋯All")]
        genreList.append(contentsOf: genres)
        for genre in genreList {
            stackView.addArrangedSubview(createButton(genre,selectedGenre == genre.name))
        }
    }
    
    func createButton(_ genre : Genre, _ isActive: Bool = false) -> UIButton{
        let button = AdaptableSizeButton()
        button.translatesAutoresizingMaskIntoConstraints = true
        button.backgroundColor = .darkGray.withAlphaComponent(isActive ? 0.7 : 0.3)
        button.setTitle(genre.name, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 24
        button.addAction(for: .touchUpInside) {
            self.selectedGenre = genre.name
            self.addButtonToScrollView(self.genres)
            self.presenter?.fetchDiscoverMovie(genre.id > 0 ? String(genre.id) : "")
        }
        
        return button
    }
    
    
   
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movie App"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .black
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .black
        collectionView.register(MovieCard.self, forCellWithReuseIdentifier: MovieCard.identifier)
        
        
        view.addSubview(uiScrollView)
        view.addSubview(textError)
        view.addSubview(collectionView)
        uiScrollView.addSubview(stackView)
        addButtonToScrollView()
        
       
        NSLayoutConstraint.activate([
            textError.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textError.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            uiScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150 ),
            uiScrollView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 12),
            uiScrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            uiScrollView.heightAnchor.constraint(equalToConstant: 50),
            
            stackView.heightAnchor.constraint(equalTo: uiScrollView.heightAnchor, multiplier: 1),
            stackView.topAnchor.constraint(equalTo: uiScrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: uiScrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: uiScrollView.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: uiScrollView.bottomAnchor, constant:12),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
    }
    
    func viewUpdate(with result: [Genre]) {
        self.genres = result
        
        DispatchQueue.main.async {
            self.textError.isHidden = true
            self.addButtonToScrollView(self.genres)
        }
    }
    
    func viewUpdate(with error: String) {
        DispatchQueue.main.async {
            self.textError.text = error
            self.textError.isHidden = false
        }
    }
    
    func viewUpdateCardMovies(with result: [Movie]) {
        self.movies = result
        DispatchQueue.main.async {
            self.textError.isHidden = true
            self.collectionView.isHidden = false
            self.collectionView.reloadData()
        }
    }
    
    func viewUpdateCardMovies(with error: String) {
        DispatchQueue.main.async {
            self.textError.text = error
            self.textError.isHidden = false
            self.collectionView.isHidden = true
        }
    }
    
    
}


#if DEBUG
import SwiftUI
struct ListGenre_Preview : PreviewProvider {
    static var previews: some View{
        ViewControllerPreview {
            ListGenreView()
        }
    }
}

struct ViewControllerPreview: UIViewControllerRepresentable {
    let viewControllerBuilder: () -> UIViewController
    
    init(_ viewControllerBuilder: @escaping () -> UIViewController) {
        self.viewControllerBuilder = viewControllerBuilder
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        return viewControllerBuilder()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // Not needed
    }
}

#endif


extension ListGenreView :  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCard.identifier, for: indexPath) as! MovieCard
        
        cell.movieName.text = self.movies[indexPath.row].title
        cell.imageView.load(url: URL(string: imageBaseUrl + self.movies[indexPath.row].posterPath!)!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: (view.frame.size.width/2 ) - 16,
            height: (view.frame.size.width/1.5 ) - 16
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 12, bottom: -8, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter?.selectedMovieID = movies[indexPath.row].id
        self.presenter?.goToDetailPage()
    }
    
    
}
