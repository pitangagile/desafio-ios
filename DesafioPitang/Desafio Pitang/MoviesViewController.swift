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
import SVProgressHUD

class MoviesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let viewModel = MoviesViewModel()
    let router = Router()
    let disposeBag = DisposeBag()
    var i = 0
    
    override func viewDidLoad() {
        self.title = "Movies"
        super.viewDidLoad()
    
        self.setupCellsHeight()
        self.setupPaging()
        self.setupCellLoading()
        self.setupSelectCell()
        self.setupLoading()
        self.setupErrorHandling()
    }
    
    private func setupCellsHeight() {
        self.tableView.rowHeight = 300
        self.tableView.estimatedRowHeight = 0.0
    }
    
    private func setupLoading() {
        self.viewModel.isLoaded
            .bind { (isLoaded) in
                if !isLoaded {
                    SVProgressHUD.show()
                } else {
                    SVProgressHUD.dismiss()
                }
            }
            .disposed(by: self.disposeBag)
    }
    
    private func setupErrorHandling() {
        self.viewModel.errorMessage
            .bind { (errorMessage) in
                if let errorMessage = errorMessage {
                    SVProgressHUD.showError(withStatus: errorMessage)
                }
            }.disposed(by: self.disposeBag)
    }
    
    private func setupCellLoading() {
        self.viewModel.movies.asObservable()
            .bind(to:self.tableView.rx.items(
                    cellIdentifier: MovieViewCell.identifier,
                    cellType: MovieViewCell.self)
            ){ row, movie, cell in
                Nuke.loadImage(with: movie.imageURL, into: cell.movieImage)
                cell.name.text = movie.name
                    
            }
            .disposed(by: self.disposeBag)
    }
    
    private func setupSelectCell() {
        self.tableView.rx.modelSelected(MovieCellViewModel.self)
            .bind { (movieCellViewModel) in
                self.router.showMovieDetail(id: movieCellViewModel.id, sender: self)
            }.disposed(by: self.disposeBag)
    }
    
    private func setupPaging() {
        self.tableView.rx
            .contentOffset
            .asObservable()
            .map(self.isNearTableViewBottom)
            .distinctUntilChanged()
            .filter {value in value == true}
            .bind { _ in self.loadPage() }
            .disposed(by: self.disposeBag)
    }
    
    private func loadPage() {
        self.viewModel.loadMovies(page: self.i)
        self.i += 1
    }
    
    private func isNearTableViewBottom(point: CGPoint) -> Bool {
        return point.y + self.tableView.frame.size.height + 20 > self.tableView.contentSize.height
    }
}

