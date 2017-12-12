//
//  MovieTableViewCell.swift
//  Movies
//
//  Created by Emre Berk on 10.12.2017.
//  Copyright © 2017 Emre Berk. All rights reserved.
//

import UIKit
import Kingfisher

class MovieTableViewCell:UITableViewCell{
    
    @IBOutlet weak var posterImageView:UIImageView!
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var releaseDateLabel:UILabel!
    @IBOutlet weak var overviewLabel:UILabel!
    
    func fill(_ movie:Movie){
        if let posterURL = movie.posterURL{
            posterImageView.kf.setImage(with: posterURL)
        }
        titleLabel.text = movie.title
        releaseDateLabel.text = movie.releaseDate
        overviewLabel.text = movie.overview
    }
    
}
