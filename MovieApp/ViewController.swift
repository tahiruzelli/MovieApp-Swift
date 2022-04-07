//
//  ViewController.swift
//  MovieApp
//
//  Created by Tahir Uzelli on 7.04.2022.
//

import UIKit
import NVActivityIndicatorView

class ViewController: UIViewController {
    var activityIndicator : NVActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let xAxis = self.view.center.x
        let yAxis = self.view.center.y
        let frame = CGRect(x: (xAxis - 22.5), y: (yAxis - 45), width: 45, height: 45)
        activityIndicator = NVActivityIndicatorView(frame: frame)
        activityIndicator.type = .ballTrianglePath
        activityIndicator.color = UIColor.red

        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }


}

