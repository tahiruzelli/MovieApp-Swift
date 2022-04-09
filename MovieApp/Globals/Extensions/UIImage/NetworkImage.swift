//
//  NetworkImage.swift
//  MovieApp
//
//  Created by Tahir Uzelli on 8.04.2022.
//

import Foundation
import UIKit
import Alamofire

extension UIImage{
    
    func downloaded(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self? = image
            }
        }.resume()
    }
    
    func downloaded(from link: String) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url)
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
//    func networkImage(link:String)->UIImage{
//        AF.request(link, method: .get).validate().responseData { (data) in)
//            guard let data = data.result.value else { return }
//            guard let photos = try? JSONDecoder().decode([Photo].self, from: data) else { return }
//            //  3. Download photos
//            for photo in photos {
//                guard let photoUrl = URL(string: photo.url) else { return }
//                guard let photoData = try? Data(contentsOf: photoUrl) else { return }
//                guard let photoImage = UIImage(data: photoData) else { return }
//                self.photos.append(photoImage)
//            }
//            // 4. Hide preloading animation and update the UI
//            self.activityIndicator.stopAnimating()
//            self.photoCollectionView.reloadData()
//        }
//    }
}
