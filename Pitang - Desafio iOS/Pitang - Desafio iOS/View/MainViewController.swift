//
//  MainViewController.swift
//  Pitang - Desafio iOS
//
//  Created by Pedro Veloso on 20/06/2018.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tvMovies: UITableView!
    
    //MARK: - Properties
    fileprivate var mainVM:MainViewModel?

    //MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainVM = MainViewModel()
        mainVM?.listMovies(at: 0)
        
        self.setupNotificationObservers()
        
        self.tvMovies.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - Setup Methods
    fileprivate func setupNotificationObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(onReceivedMovieList), name: NOTIFICATION_receivedListMovies, object: nil)
        
    }
    
    //MARK: - UITableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let movies = self.mainVM?.moviesList{
            return movies.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cId_movie", for: indexPath)
        let model = self.mainVM?.moviesList[indexPath.row]

        cell.setupCell(using: model)
        
        return cell
    }
    
    //MARK: - Other Methods
    @objc func onReceivedMovieList(notification: Notification?){
        if let error = notification?.object as? NSError {
            AlertHelper.showDefaultSimpleAlert(title: "Ops!", mensage: error.domain, parent: self, buttonTitle: "Retry") {
                self.mainVM?.listMovies(at: (self.mainVM?.lastPage)!)
            }
        }else{
            self.tvMovies.reloadData()
        }
    }
}
