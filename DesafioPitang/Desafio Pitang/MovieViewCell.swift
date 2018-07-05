//
//  MovieViewCell.swift
//  Desafio Pitang
//
//  Created by Filipe Jordão on 21/06/18.
//  Copyright © 2018 Filipe Jordão. All rights reserved.
//

import UIKit

class MovieViewCell: UITableViewCell {
    static let identifier = "MovieCell"
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var name: UILabel!
}
