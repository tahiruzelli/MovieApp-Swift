//
//  MovieTableViewCell.swift
//  MovieApp
//
//  Created by Tahir Uzelli on 8.04.2022.
//
import Foundation
import UIKit

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var movieDate: UILabel!
    
    @IBOutlet weak var movieDesc: UILabel!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    override func layoutSubviews() {
        movieImage.clipsToBounds = true
        movieImage.layer.cornerRadius = 10
        movieImage.contentMode = .scaleToFill
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()


    }
    
}
