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
import Nuke
class MoviesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let viewModel = MoviesViewModel()
    var i = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 200
        
        self.setupPaging()
        self.setupCellLoading()
    }
    
    private func setupPaging() {
        let _ = self.viewModel.movies.asObservable().bind(to:
            self.tableView.rx.items(
                cellIdentifier: MovieViewCell.identifier,
                cellType: MovieViewCell.self)){ row, movie, cell in
                    
                    self.tableView.setContentOffset(self.tableView.contentOffset, animated: false)
                    Nuke.loadImage(with: movie.url, into: cell.movieImage)
                    cell.name.text = movie.name
        }
    }
    
    private func setupCellLoading() {
        let _ = self.tableView.rx
            .contentOffset
            .asObservable()
            .map(self.isNearTableViewBottom)
            .distinctUntilChanged()
            .filter {value in value == true}
            .bind { _ in self.loadPage() }
    }
    
    private func loadPage() {
        self.viewModel.loadMovies(page: self.i)
        self.i += 1
    }
    
    private func isNearTableViewBottom(point: CGPoint) -> Bool {
        return point.y + self.tableView.frame.size.height + 20 > self.tableView.contentSize.height
    }
}

