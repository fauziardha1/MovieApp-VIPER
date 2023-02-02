//
//  MovieCard.swift
//  MovieApp-VIPER
//
//  Created by FauziArda on 02/02/23.
//

import UIKit

class MovieCard: UICollectionViewCell {
    static let identifier = "TextItemCell"
    
    lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var movieName : UILabel = {
        let label = UILabel()
        
        label.text = "Movie 1"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 12.0)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(movieName)
        contentView.backgroundColor = .systemGray.withAlphaComponent(0.3)
        contentView.layer.cornerRadius = 12
        
       
        
        imageView.image = UIImage(systemName: "film.fill")
        imageView.tintColor = .white
        imageView.layer.cornerRadius = 24
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8),
            
            
            movieName.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            movieName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            movieName.widthAnchor.constraint(equalTo: contentView.widthAnchor)
            
            
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        imageView.image = nil
    }
}
