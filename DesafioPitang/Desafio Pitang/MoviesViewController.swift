//
//  ViewController.swift
//  Desafio Pitang
//
//  Created by Filipe Jordão on 21/06/18.
//  Copyright © 2018 Filipe Jordão. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class MoviesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PitangMovieDataStore().moviesList(page: 0, pageSize: 1000)
    }
}

