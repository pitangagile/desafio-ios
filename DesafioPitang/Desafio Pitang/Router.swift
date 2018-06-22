//
//  Router.swift
//  Desafio Pitang
//
//  Created by Filipe Jordão on 21/06/18.
//  Copyright © 2018 Filipe Jordão. All rights reserved.
//

import Foundation
import Rswift
import UIKit

class Router {
    func showMovieDetail(id: String, sender: UIViewController) {
        let viewModel = MovieDetailsViewModel(movieId: id)
        
        let detailsVC = R.storyboard.main.movieDetailViewController()
        detailsVC?.viewModel = viewModel
        
        sender.navigationController?.pushViewController(detailsVC!, animated: true)
    }
}
