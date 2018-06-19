//
//  ViewController.swift
//  desafioIOS
//
//  Created by CITi on 19/06/18.
//  Copyright © 2018 CITi. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var data: [(String, UIImage)] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data = [("One", UIImage(named: "cat")!), ("Two", UIImage(named: "cat")!), ("Three", UIImage(named: "cat")!)]
        self.tableView.delegate = self
        self.tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
        let headers: HTTPHeaders = ["content-type": "application/json"]
        let parameters: Parameters = [
            "page": "0",
            "size": "3"
        ]
        
        Alamofire.request("https://desafio-mobile-pitang.herokuapp.com/movies/list?", method: .get, parameters: parameters, headers: headers).responseJSON { (response) in
            print("AQUI")
            print(response)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieTableViewCell
        cell.movieName.text = data[indexPath.row].0
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

