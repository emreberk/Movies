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
    
    var viewModel:MovieListViewModel!

    override func viewDidLoad() {
        title = viewModel.searchText
        viewModel.delegate = self
    }
    
    deinit{
        print("MovieListViewController deinit")
    }
    
}

extension MovieListViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as! MovieTableViewCell
        let cellViewModel = viewModel.cellViewModels[indexPath.row]
        cell.fill(cellViewModel)
        return cell
    }
    
}

extension MovieListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.cellViewModels.count - 4{
            print(#function,indexPath.row)
            viewModel.loadMore()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension MovieListViewController: MovieListViewModelDelegate{
    func cellViewModelsDidChanged() {
        tableView.reloadData()
    }
    func serviceError(withMessage message: String) {
        let vc = UIAlertController(title: Constants.ErrorMessages.ErrorTitle,
                                   message: message,
                                   preferredStyle: .alert)
        vc.addAction(UIAlertAction(title: Constants.OkayButtonTitle,
                                   style: .default,
                                   handler: nil))
        present(vc, animated: true, completion: nil)
    }
}
