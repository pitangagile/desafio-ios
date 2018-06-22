//
//  MovieDetailsViewModel.swift
//  Desafio Pitang
//
//  Created by Filipe Jordão on 21/06/18.
//  Copyright © 2018 Filipe Jordão. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
class MovieDetailsViewModel {
    let disposeBag = DisposeBag()
    let title = BehaviorRelay<String>(value: "")
    let description = BehaviorRelay<String>(value: "")
    let imageURL = BehaviorRelay<URL?>(value: nil)
    let isLoaded = BehaviorRelay<Bool>(value: false)
    let errorMessage = BehaviorRelay<String?>(value: nil)
    
    init(movieId: String) {
        PitangMovieDataStore()
            .movieDetail(id: movieId)
            .subscribe({ (event) in
                switch event {
                case let .next(movie):
                    self.title.accept(movie.name)
                    self.imageURL.accept(movie.url)
                    self.description.accept(movie.description)
                    
                case .error:
                    self.errorMessage.accept("Oops... Something went wrong...")
                    
                case .completed:
                    self.isLoaded.accept(true)
                }
            })
            .disposed(by: self.disposeBag)
    }
}
