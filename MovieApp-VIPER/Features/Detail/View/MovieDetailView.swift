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
    
    private lazy var errorLabel : UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        label.numberOfLines = 100
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detail"
        view.backgroundColor = .black
        
        view.addSubview(errorLabel)
        
        NSLayoutConstraint.activate([
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
    }
}


extension MovieDetailView : MovieDetailViewContract{
    func viewUpdate(with result: MovieDetail) {
        
        DispatchQueue.main.async {
            self.errorLabel.text = String(describing: result)
            self.errorLabel.isHidden = false
        }
    }
    
    func viewUpdate(with error: String) {
        print(error)
        DispatchQueue.main.async {
            self.errorLabel.text = error
            self.errorLabel.isHidden = false
        }
    }
    
    func viewUpdateReview(with result: MovieReview) {
        print("do something")
    }
    
    
}
