//
//  MainViewController.swift
//  Pitang - Desafio iOS
//
//  Created by Pedro Veloso on 20/06/2018.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let CELL_HEIGHT:CGFloat = 60.0
    
    //MARK: - IBOutlets
    @IBOutlet weak var tvMovies: UITableView!
    
    //MARK: - Properties
    fileprivate var mainVM:MainViewModel?

    //MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainVM = MainViewModel()
        mainVM?.countSize = Int(UIScreen.main.bounds.size.height / CELL_HEIGHT)
        mainVM?.listMovies(at: 0)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onReceivedMovieList), name: NOTIFICATION_receivedListMovies, object: nil)
        
        self.tvMovies.dataSource = self
        self.tvMovies.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "segueDetailMovie", sender: self.mainVM?.moviesList[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CELL_HEIGHT
    }
    
    //MARK: - ScrollView Methods
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let  height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            
            if let mainVM = self.mainVM {
                mainVM.listMovies(at: mainVM.lastPage + 1)
            }
            
        }
    }
    
    //MARK: - Other Methods
    @objc func onReceivedMovieList(notification: Notification?){
        DispatchQueue.main.async {
            if let error = notification?.object as? NSError {
                AlertHelper.showDefaultSimpleAlert(title: "Ops!", mensage: error.domain, parent: self, buttonTitle: "Retry") {
                    self.mainVM?.listMovies(at: (self.mainVM?.lastPage)!)
                }
            }else{
                self.tvMovies.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "segueDetailMovie"){
            if let detail = segue.destination as? DetailViewController, let movie = sender as? MovieModel {
                detail.detailVM = DetailViewModel()
                detail.detailVM?.movie = movie
                
            }
        }
    }
}
