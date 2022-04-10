//
//  NowPlayingMovieCell.swift
//  MovieApp
//
//  Created by Tahir Uzelli on 10.04.2022.
//

import Foundation
import UIKit

class NowPlayingMovieCell : UICollectionViewCell{
  
    private let coverImage: UIImageView = {
       let image = UIImageView()
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
    override func prepareForReuse() {
        super.prepareForReuse()
        coverImage.image  = nil
        titleLabel.text = nil
        overviewLabel.text = nil
    }
     
    private let overviewLabel: UILabel = {
        let label = UILabel()
    
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
         return label
     }()
     
    static let identifier = "NowPlayingMovieCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        addSubViews()
    }
    
    public func set(title: String, overview: String, image: String) {

        self.coverImage.downloaded(from: imageBaseUrl + image, contentMode: .scaleToFill)
        self.overviewLabel.text = overview
        self.titleLabel.text = title
    }
}


// MARK: - UILayout
extension NowPlayingMovieCell {
    
    private func addSubViews() {
        addImageLabel()
        addNameLabel()
        addDescLabel()
        
    }
    
    private func addNameLabel() {
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: coverImage.topAnchor,constant: 80),
            titleLabel.leadingAnchor.constraint(equalTo: coverImage.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: coverImage.trailingAnchor, constant: -16),
        ])
    }
    private func addDescLabel() {
        contentView.addSubview(overviewLabel)
              NSLayoutConstraint.activate([
                overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 4),
                overviewLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                overviewLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
                overviewLabel.bottomAnchor.constraint(equalTo: coverImage.bottomAnchor, constant: -8)
              ])
    }
    private func addImageLabel() {
        contentView.addSubview(coverImage)
        NSLayoutConstraint.activate([
            coverImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            coverImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            coverImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            coverImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

