//
//  MovieListViewModel.swift
//  Movies
//
//  Created by Emre Berk on 12.12.2017.
//  Copyright © 2017 Emre Berk. All rights reserved.
//

import Foundation

protocol MovieListViewModelDelegate:class{
    func cellViewModelsDidChanged()
    func serviceError(withMessage message:String)
}

class MovieListViewModel{
    
    var searchText:String!
    var cellViewModels = [MovieCellViewModel]()

    weak var delegate:MovieListViewModelDelegate?
    
    private var service:ServiceProtocol!
    private var serviceResponse:SearchMovieResponse!
    private var isSearching = false
    
    init(searchMovieResponse:SearchMovieResponse, service: ServiceProtocol = MovieService()){
        self.service = service
        self.serviceResponse = searchMovieResponse
        self.createCellViewModels(forMovies: serviceResponse.movies)
    }
    
    func loadMore(){
        if isSearching || serviceResponse.page == serviceResponse.totalPages{ return }
        isSearching = true
        let endpoint = MovieEndpoint.searchMovie(query: searchText, page: serviceResponse.page + 1)
        service.request(endpoint) { (t:SearchMovieResponse?, error) in
            if let response = t{
                self.handleResponse(response)
            }else if let error = error{
                self.handleError(error)
            }
            self.isSearching = false
        }
    }
    
    private func createCellViewModels(forMovies movies:[Movie]){
        for movie in movies{
            cellViewModels.append(MovieCellViewModel(movie))
        }
        delegate?.cellViewModelsDidChanged()
    }
    
    private func handleResponse(_ response:SearchMovieResponse){
        serviceResponse.page = response.page
        serviceResponse.movies.append(contentsOf: response.movies)
        createCellViewModels(forMovies: response.movies)
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
