//
//  MovieDetailsViewController.swift
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

class MovieDetailsViewController: UIViewController {
    let disposeBag = DisposeBag()
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieDescriptionTextView: UITextView!
 
    var viewModel: MovieDetailsViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel?.isLoaded
            .asObservable()
            .bind(onNext: { (isLoaded) in
                if !isLoaded {
                    SVProgressHUD.show()
                } else {
                    SVProgressHUD.dismiss()
                }
            })
            .disposed(by: self.disposeBag)
        
        self.viewModel?.imageURL
            .asObservable()
            .bind { (url) in
                if let url = url {
                    Nuke.loadImage(with: url, into: self.movieImageView)
                }
            }
            .disposed(by: self.disposeBag)
        
        self.viewModel?.description
            .asObservable()
            .bind(to: self.movieDescriptionTextView.rx.text)
            .disposed(by: self.disposeBag)
        
        self.viewModel?.title
            .asObservable()
            .bind(to: self.rx.title)
            .disposed(by: self.disposeBag)
        
        self.viewModel?.errorMessage
            .asObservable()
            .bind(onNext: { (errorMessage) in
                if let errorMessage = errorMessage {
                    SVProgressHUD.showError(withStatus: errorMessage)
                }
            })
            .disposed(by: self.disposeBag)
    }
    
}
