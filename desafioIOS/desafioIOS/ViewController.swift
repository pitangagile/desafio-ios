//
//  ViewController.swift
//  desafioIOS
//
//  Created by CITi on 19/06/18.
//  Copyright © 2018 CITi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var data: [Movie] = []
    var page: Int = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        handlePagination()
        
    }
    
    func handlePagination() {
        ApiComunication.getMoviesList(page: page, size: 5, onSuccess: { (movies) in
            self.data.append(contentsOf: movies)
            for movie in self.data {
                ApiComunication.imageDownloadTask(imageURL: movie.imageURL!, onSuccess: { (image, imageURL) in
                    var i = 0
                    for element in self.data {
                        let url = URL(string: element.imageURL!)
                        if url == imageURL {
                            self.data[i].image = image
                        }
                        i += 1
                    }
                    self.tableView.reloadData()
                }, onFailure: { (error) in
                    print(error)
                })
            }
            self.tableView.reloadData()
        }) { (error) in
            print(error)
        }
        page += 1
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let currentOffset = scrollView.contentOffset.y
        let maxOffset = scrollView.contentSize.height - scrollView.frame.height
        if maxOffset - currentOffset <= 40 {
            self.handlePagination()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue" {
            let nextView = segue.destination as! DescriptionViewController
            let row = self.tableView.indexPathForSelectedRow?.row
            nextView.movieID = self.data[row!].id!
            nextView.image = self.data[row!].image
            nextView.name = self.data[row!].name
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

