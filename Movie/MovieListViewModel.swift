//
//  MovieListViewModel.swift
//  Movie
//
//  Created by Grace Liaw on 15/1/22.
//

import Foundation

class MovieListViewModel: ObservableObject {
    @Published var popularMovieList: [Movie] = [Movie]()
    @Published var upcomingMovieList: [Movie] = [Movie]()

    private var popularCurrPage = 1
    private var upcomingCurrPage = 1
    private var loadMorePopularPage = true
    private var loadMoreUpcomingPage = true

    // MARK: - Init & Deinit
    init() {
        getPopularMovies()
        getUpcomingMovies()
    }
    
    func getPopularMovies() {
        fetchPopularMovies(pageNo: popularCurrPage)
    }
    
    func getUpcomingMovies() {
        fetchUpcomingMovies(pageNo: upcomingCurrPage)
    }
    
    func fetchPopularMovies(pageNo: Int) {
        guard loadMorePopularPage else {
            return
        }
        
        let urlString = String(format: "https://api.themoviedb.org/3/movie/popular?api_key=6b69aa48b6d27d02ad773aa94ed945bc&page=%i", pageNo)
        let url = URL(string: urlString)!
        let apiRequest = APIRequest(url: url)
        apiRequest.callRequest { result in
            switch result {
            case .success(let movieInfo):
                if self.popularCurrPage > movieInfo.totalPages ?? 0 {
                    self.loadMorePopularPage = false
                }

                self.popularCurrPage += 1
                self.savePopularMovieData(movieInfo: movieInfo.results ?? [Movie]())
                DispatchQueue.main.async {
                    self.popularMovieList.append(contentsOf: movieInfo.results ?? [Movie]())
                }
            case .failure(let error):
                debugPrint(error)
                if self.popularMovieList.count < 1 {
                    self.fetchSavedPopularMovieData()
                }
            }
        }
    }
    
    private func savePopularMovieData(movieInfo: [Movie]) {
        var savedPopularMovieList: [Movie] = [Movie]()
        if let decodedData = UserDefaults.standard.object(forKey: "savedPopularList") as? Data {
           if let movieList = try? JSONDecoder().decode([Movie].self, from: decodedData) {
               savedPopularMovieList = movieList
               print("savedPopList: \(savedPopularMovieList.description)")
          }
        }
        for movie in movieInfo {
            if !savedPopularMovieList.contains(where: {$0.id==movie.id}) {
                savedPopularMovieList.append(contentsOf: movieInfo)
            }
        }
        if let encodedList = try? JSONEncoder().encode(savedPopularMovieList) {
           UserDefaults.standard.set(encodedList, forKey: "savedPopularList")
        }
    }
    
    private func fetchSavedPopularMovieData() {
        var savedPopularMovieList: [Movie] = [Movie]()
        if let decodedData = UserDefaults.standard.object(forKey: "savedPopularList") as? Data {
           if let movieList = try? JSONDecoder().decode([Movie].self, from: decodedData) {
               savedPopularMovieList = movieList
               print("savedPopList: \(savedPopularMovieList.description)")
          }
        }
        
        DispatchQueue.main.async {
            self.popularMovieList.append(contentsOf: savedPopularMovieList)
        }
    }
        
    func fetchUpcomingMovies(pageNo: Int) {
        guard loadMoreUpcomingPage else {
            return
        }
        
        let urlString = String(format: "https://api.themoviedb.org/3/movie/upcoming?api_key=6b69aa48b6d27d02ad773aa94ed945bc&page=%i", pageNo)
        let url = URL(string: urlString)!
        let apiRequest = APIRequest(url: url)
        apiRequest.callRequest { result in
            switch result {
            case .success(let movieInfo):
                if self.upcomingCurrPage > movieInfo.totalPages ?? 0 {
                    self.loadMoreUpcomingPage = false
                }

                self.upcomingCurrPage += 1
                self.saveUpcomingMovieData(movieInfo: movieInfo.results ?? [Movie]())
                DispatchQueue.main.async {
                    self.upcomingMovieList.append(contentsOf: movieInfo.results ?? [Movie]())
                }
            case .failure(let error):
                debugPrint(error)
                if self.popularMovieList.count < 1 {
                    self.fetchSavedUpcomingMovieData()
                }
            }
        }
    }
    
    private func saveUpcomingMovieData(movieInfo: [Movie]) {
        var savedUpcomingMovieList: [Movie] = [Movie]()
        if let decodedData = UserDefaults.standard.object(forKey: "savedUpcomingList") as? Data {
           if let movieList = try? JSONDecoder().decode([Movie].self, from: decodedData) {
               savedUpcomingMovieList = movieList
               print("savedUpList: \(savedUpcomingMovieList.description)")
          }
        }
        for movie in movieInfo {
            if !savedUpcomingMovieList.contains(where: {$0.id==movie.id}) {
                savedUpcomingMovieList.append(contentsOf: movieInfo)
            }
        }
        if let encodedList = try? JSONEncoder().encode(savedUpcomingMovieList) {
           UserDefaults.standard.set(encodedList, forKey: "savedUpcomingList")
        }
    }
    
    private func fetchSavedUpcomingMovieData() {
        var savedUpcomingMovieList: [Movie] = [Movie]()
        if let decodedData = UserDefaults.standard.object(forKey: "savedUpcomingList") as? Data {
           if let movieList = try? JSONDecoder().decode([Movie].self, from: decodedData) {
               savedUpcomingMovieList = movieList
               print("savedUpList: \(savedUpcomingMovieList.description)")
          }
        }
        
        DispatchQueue.main.async {
            self.upcomingMovieList.append(contentsOf: savedUpcomingMovieList)
        }
    }
}
