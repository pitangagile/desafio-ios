//
//  MoviesViewModel.swift
//  Desafio Pitang
//
//  Created by Filipe Jordão on 21/06/18.
//  Copyright © 2018 Filipe Jordão. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
class MoviesViewModel {
    let disposeBag = DisposeBag()
    
    let movies = BehaviorRelay<[MovieCellViewModel]>(value: [])
    let errorMessage = BehaviorRelay<String?>(value: nil)
    let isLoaded = BehaviorRelay<Bool>(value: false)
    
    let dataStore = PitangMovieDataStore()
    
    func loadMovies(page: Int) {
        self.dataStore
            .moviesList(page: page, pageSize: 6)
            .map(self.viewModels)
            .subscribe { (event) in
                switch event {
                case .next(let movies):
                    if !movies.isEmpty {
                        self.movies.accept(self.movies.value + movies)
                    }
                case .error(_):
                    self.errorMessage.accept("Ooops... Something went wrong")
                    
                case .completed:
                    self.isLoaded.accept(true)
                }
            }.disposed(by: self.disposeBag)
    }
    
    private func viewModels(from moviePreviews: [MoviePreview]) -> [MovieCellViewModel] {
        return moviePreviews.map({ (movie) -> MovieCellViewModel in
            return MovieCellViewModel(id: movie._id, imageURL: movie.url, name: movie.name)
        })
    }
}
