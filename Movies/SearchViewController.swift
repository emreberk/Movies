//
//  SearchViewController.swift
//  Movies
//
//  Created by Emre Berk on 10.12.2017.
//  Copyright © 2017 Emre Berk. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar:UISearchBar!
    @IBOutlet weak var tableView:UITableView!
    
    var service:ServiceProtocol = MovieService()
    var storage:StorageProtocol = UserDefaultsStorage()
    var lastQueries = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        lastQueries = storage.getLastQueries()
        tableView.reloadData()
    }
    
    func showMovieListViewController(withSearchKey searchKey:String, movies:[Movie]){
        let vc = storyboard!.instantiateViewController(withIdentifier: "MovieListViewController") as! MovieListViewController
        vc.searchText = searchKey
        vc.movies = movies
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func searchMovies(for key:String){
        let endpoint = MovieEndpoint.searchMovie(query: key, page: 1)
        service.request(endpoint) { (t:SearchMovieResponse?, error) in
            if let movies = t?.movies{
                self.showMovieListViewController(withSearchKey: key, movies: movies)
            }else if let error = error{
                switch error{
                case .service(_, let message):
                    print(message)
                default:
                    print("an error occured")
                }
            }
        }
    }

}

extension SearchViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchText = searchBar.text ?? ""
        storage.addNewQuery(searchText)
        lastQueries = storage.getLastQueries()
        tableView.reloadData()
        //showMovieListViewController(with: searchText)
        //searchBar.endEditing(true)
    }
}

extension SearchViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lastQueries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchSuggestTableViewCell") as! SearchSuggestTableViewCell
        cell.suggestLabel.text = lastQueries[indexPath.row]
        return cell
    }
    
}

extension SearchViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let string = lastQueries[indexPath.row]
        searchMovies(for: string)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
