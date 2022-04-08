//
//  ImageTextField.swift
//  MovieApp
//
//  Created by Tahir Uzelli on 8.04.2022.
//

import Foundation
import UIKit

extension UITextField {
    
    enum Direction {
        case Left
        case Right
    }

    // add image to textfield
    func withImage(direction: Direction, image: UIImage){
        let mainView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 45))

        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 45))
        view.clipsToBounds = true
        mainView.addSubview(view)

        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 12.0, y: 10.0, width: 24.0, height: 24.0)
        view.addSubview(imageView)

        let seperatorView = UIView()
        mainView.addSubview(seperatorView)

        if(Direction.Left == direction){ // image left
            seperatorView.frame = CGRect(x: 45, y: 0, width: 5, height: 45)
            self.leftViewMode = .always
            self.leftView = mainView
        } else { // image right
            seperatorView.frame = CGRect(x: 0, y: 0, width: 5, height: 45)
            self.rightViewMode = .always
            self.rightView = mainView
        }
        self.layer.cornerRadius = 5
    }

    }
