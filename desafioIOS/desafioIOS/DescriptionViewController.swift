//
//  DescriptionViewController.swift
//  desafioIOS
//
//  Created by CITi on 19/06/18.
//  Copyright © 2018 CITi. All rights reserved.
//

import UIKit

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
