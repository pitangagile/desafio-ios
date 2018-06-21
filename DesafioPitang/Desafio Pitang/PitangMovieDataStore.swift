//
//  PitangMovieDataStore.swift
//  Desafio Pitang
//
//  Created by Filipe Jordão on 21/06/18.
//  Copyright © 2018 Filipe Jordão. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

class PitangMovieDataStore {
    let provider = MoyaProvider<PitangMoviesAPI>()
    
    func moviesList(page: Int, pageSize: Int)  {
        self.provider.rx
            .request(.movies(page: page, pageSize: pageSize))
            .map([MoviePreview].self)
            .asObservable()
            .catchError({ (err) -> Observable<[MoviePreview]> in
                print(err)
                return Variable<[MoviePreview]>([]).asObservable()
            })
            .subscribe { (movies) in
               print(movies)
        }
        
    }
}
