//
//  SearchViewModel.swift
//  Movies
//
//  Created by Emre Berk on 12.12.2017.
//  Copyright © 2017 Emre Berk. All rights reserved.
//

import Foundation

protocol SearchViewModelDelegate:class{
    func serviceSucceed(withViewModel viewModel:MovieListViewModel)
    func serviceError(withMessage message:String)
    func networkingStarted()
    func networkingFinished()
    func lastQueriesDidChanged()
}

class SearchViewModel{
    
    private var storage:StorageProtocol!
    private var service:ServiceProtocol!
    private var isSearching = false{
        didSet{
            isSearching ? delegate?.networkingStarted() : delegate?.networkingFinished()
        }
    }
    private var searchKey:String?
    
    weak var delegate:SearchViewModelDelegate?
    
    private(set) var lastQueries = [String](){
        didSet{
            delegate?.lastQueriesDidChanged()
        }
    }
    
    init(_ storage:StorageProtocol = UserDefaultsStorage(), _ service:ServiceProtocol = MovieService()){
        self.storage = storage
        self.service = service
    }
    
    func fetchLastQueries(){
        lastQueries = storage.getLastQueries()
    }
    
    func searchMovies(for key:String){
        if isSearching { return }
        isSearching = true
        searchKey = key
        let endpoint = MovieEndpoint.searchMovie(query: key, page: 1)
        service.request(endpoint) { (t:SearchMovieResponse?, error) in
            if let response = t{
                self.handleResponse(response)
            }else if let error = error{
                self.handleError(error)
            }
            self.isSearching = false
        }
    }
    
    private func handleResponse(_ response:SearchMovieResponse){
        if response.movies.count == 0{
            delegate?.serviceError(withMessage: Constants.ErrorMessages.NoMovieFound)
        }else{
            guard let searchKey = searchKey else{ return }
            
            storage.addNewQuery(searchKey)
            fetchLastQueries()
            
            let movieListViewModel = MovieListViewModel(searchMovieResponse: response)
            movieListViewModel.searchText = searchKey
            self.delegate?.serviceSucceed(withViewModel: movieListViewModel)
        }
    }
    
    private func handleError(_ error:ServiceError){
        switch error {
        case .service(_, let message):
            delegate?.serviceError(withMessage: message)
        default:
            delegate?.serviceError(withMessage: Constants.ErrorMessages.General)
        }
    }
    
}
