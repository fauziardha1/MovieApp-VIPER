//
//  ViewEx.swift
//  MovieApp-VIPER
//
//  Created by FauziArda on 02/02/23.
//

import Foundation
import UIKit

class AdaptableSizeButton: UIButton {
    override var intrinsicContentSize: CGSize {
        let labelSize = titleLabel?.sizeThatFits(CGSize(width: frame.size.width, height: CGFloat.greatestFiniteMagnitude)) ?? .zero
        let desiredButtonSize = CGSize(width: labelSize.width + titleEdgeInsets.left + titleEdgeInsets.right + 24, height: labelSize.height + titleEdgeInsets.top + titleEdgeInsets.bottom)
        
        return desiredButtonSize
    }
}

extension UIControl {
  func addAction(for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping()->()) {
      @objc class ClosureSleeve: NSObject {
          let closure:()->()
          init(_ closure: @escaping()->()) { self.closure = closure }
          @objc func invoke() { closure() }
      }
      let sleeve = ClosureSleeve(closure)
      addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
      objc_setAssociatedObject(self, "\(UUID())", sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
  }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

let imageBaseURL : String = "https://image.tmdb.org/t/p/w500"
