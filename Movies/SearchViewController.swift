//
//  SearchViewController.swift
//  Movies
//
//  Created by Emre Berk on 10.12.2017.
//  Copyright © 2017 Emre Berk. All rights reserved.
//

import UIKit
import JGProgressHUD

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar:UISearchBar!
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var tableViewBottomConstraint:NSLayoutConstraint!
    private lazy var hud = JGProgressHUD(style: .dark)
    
    var viewModel:SearchViewModel! = SearchViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.fetchLastQueries()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let indexPath = tableView.indexPathForSelectedRow{
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

extension SearchViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchText = searchBar.text ?? ""
        viewModel.searchMovies(for: searchText)
    }
}

extension SearchViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.lastQueries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchSuggestTableViewCell") as! SearchSuggestTableViewCell
        cell.suggestLabel.text = viewModel.lastQueries[indexPath.row]
        return cell
    }
}

extension SearchViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let query = viewModel.lastQueries[indexPath.row]
        viewModel.searchMovies(for: query)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

// MARK: Keyboard methods
extension SearchViewController{
    @objc func keyboardWillHide(_ notification:Notification){
        guard let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double
            else{ return }
        tableViewBottomConstraint.constant = 0
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillShow(_ notification:Notification){
        guard let info = notification.userInfo,
            let value = info[UIKeyboardFrameEndUserInfoKey] as? NSValue,
            let duration = info[UIKeyboardAnimationDurationUserInfoKey] as? Double
            else{ return }
        let keyboardHeight = value.cgRectValue.size.height
        tableViewBottomConstraint.constant = keyboardHeight
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
}

extension SearchViewController: SearchViewModelDelegate{
    func serviceSucceed(withViewModel viewModel: MovieListViewModel) {
        searchBar.endEditing(true)
        searchBar.text = nil
        let vc = storyboard!.instantiateViewController(withIdentifier: "MovieListViewController") as! MovieListViewController
        vc.viewModel = viewModel
        navigationController?.pushViewController(vc, animated: true)
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
    
    func networkingStarted() {
        hud.show(in:self.view)
    }
    
    func networkingFinished() {
        hud.dismiss()
    }
    
    func lastQueriesDidChanged() {
        tableView.reloadData()
    }
}
