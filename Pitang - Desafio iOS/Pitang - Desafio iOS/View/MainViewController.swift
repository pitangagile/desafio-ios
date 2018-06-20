//
//  MainViewController.swift
//  Pitang - Desafio iOS
//
//  Created by Pedro Veloso on 20/06/2018.
//

import UIKit

class MainViewController: UIViewController {
    //MARK: - Properties
    fileprivate var mainVM:MainViewModel?

    //MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupNotificationObservers()
        
        mainVM = MainViewModel()
        mainVM?.listMovies(at: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - Setup Methods
    fileprivate func setupNotificationObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(onReceivedMovieList), name: NOTIFICATION_receivedListMovies, object: nil)
        
    }
    
    //MARK: - Other Methods
    @objc func onReceivedMovieList(notification: Notification){
        
    }
}
