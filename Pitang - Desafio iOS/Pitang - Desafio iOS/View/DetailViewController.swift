//
//  DetailViewController.swift
//  Pitang - Desafio iOS
//
//  Created by Pedro Veloso on 21/06/2018.
//

import UIKit

class DetailViewController: UIViewController {
    
    //MARK: - Properties
    var detailVM: DetailViewModel?
    
    //MARK: - IBOutlets
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var ivCover: UIImageView!
    @IBOutlet weak var tvDetail: UITextView!
    
    
    //MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(onReceivedDetailMovie), name: NOTIFICATION_receivedListMovies, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationItem.title = "Detalhes"
        
        if let detailVM = self.detailVM, let movie = detailVM.movie {
            detailVM.detailMovie(id: movie.id!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func setupComponents(){
        if let detail = self.detailVM, let movie = detail.movie {
            self.lbTitle.text = movie.name
            
            if let desc = movie.desc {
                self.tvDetail.text = desc
            }else{
                self.tvDetail.text = ""
            }
            
            ServiceHelper.downloadImage(url: movie.imageUrl!, id: movie.id!) { (image) in
                self.ivCover.image = image
            }
        }
        
        
    }
    
    @objc func onReceivedDetailMovie(notification: Notification){
        if let error = notification.object as? NSError {
            AlertHelper.showDefaultSimpleAlert(title: "Ops!", mensage: error.domain, parent: self, buttonTitle: "Retry") {
                self.detailVM?.detailMovie(id: (self.detailVM?.movie?.id)!)
            }
            
        }else{
            self.setupComponents()
        }
    }
}
