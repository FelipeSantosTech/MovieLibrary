//
//  ViewModel.swift
//  MovieLibrary
//
//  Created by Paulo Marcelo Santos on 26/02/26.
//

import Foundation

@Observable
class ViewModel {
    enum FetchStatus {
        case notStarted
        case fetching
        case success
        case failed (underlyingError: Error)
    }
    private(set) var homeStatus: FetchStatus = .notStarted
    private let dataFetcher = DataFetcher()
    var trendingMovies: [Title] = []
    
    func getTitles() async {
        homeStatus = .fetching
        
        do {
            trendingMovies = try await dataFetcher.fetchTitles(for: "movie", by: "treding")
            homeStatus = .success
        } catch {
            print(error)
            homeStatus = .failed(underlyingError: error)
        }
    }
}
