//
//  ViewController.swift
//  desafioIOS
//
//  Created by CITi on 19/06/18.
//  Copyright © 2018 CITi. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var data: [Movie] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        ApiComunication.getMoviesList(page: 0, size: 3, onSuccess: { (movie) in
            self.data.append(movie)
            self.tableView.reloadData()
        }) { (error) in
            print(error)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieTableViewCell
        cell.movieName.text = data[indexPath.row].name
        cell.movieImage.image = data[indexPath.row].image
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

