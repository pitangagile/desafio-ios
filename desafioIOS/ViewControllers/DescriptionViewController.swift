//
//  DescriptionViewController.swift
//  desafioIOS
//
//  Created by CITi on 19/06/18.
//  Copyright © 2018 CITi. All rights reserved.
//

import UIKit

/*Movie details view*/
class DescriptionViewController: UIViewController {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieDescription: UITextView!
    
    var image: UIImage?
    var name: String?
    var detail: String?
    var movieID: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.movieName.text = name
        self.movieImage.image = image
        
        //Requesting the movie description
        ApiComunication.getMovieDescription(movieID: movieID, onSuccess: { (detail) in
            self.movieDescription.text = detail
        }) { (error) in
            print(error)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
