//
//  MovieListViewController.swift
//  Movies
//
//  Created by Emre Berk on 10.12.2017.
//  Copyright © 2017 Emre Berk. All rights reserved.
//

import UIKit

class MovieListViewController:UIViewController{
    
    @IBOutlet weak var tableView:UITableView!
    
    var searchText:String!
    var movies = [Movie]()

    override func viewDidLoad() {
        title = searchText
    }
    
    deinit{
        print("MovieListViewController deinit")
    }
    
}

extension MovieListViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as! MovieTableViewCell
        let movie = movies[indexPath.row]
        cell.fill(movie)
        return cell
    }
    
}

extension MovieListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
