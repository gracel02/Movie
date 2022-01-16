//
//  FavouritesViewModel.swift
//  Movie
//
//  Created by Grace Liaw on 16/1/22.
//

import Foundation

class FavouritesViewModel: ObservableObject {
    @Published var favouriteMovieList: [Movie] = [Movie]()
    
    // the key we're using to read/write in UserDefaults
    private let favKey = "Favorites"

    init() {
        // load our saved data
                
        if let decodedData = UserDefaults.standard.object(forKey: favKey) as? Data {
           if let movieList = try? JSONDecoder().decode([Movie].self, from: decodedData) {
            favouriteMovieList = movieList
               print("favMovie: \(favouriteMovieList.description)")
          }
        }
    }
    
    // returns true if our set contains this resort
    func contains(movie: Movie) -> Bool {
        if favouriteMovieList.contains(where: {$0.id==movie.id}) {
            return true
        }else{
            return false
        }
    }
    
    func toggleFavourites(movie: Movie, isSet: Bool) {
        if isSet {
            print("fav add movie")
            add(movie: movie)
        }else{
            print("fav remove movie")
            remove(movie: movie)
        }
    }
    
    // adds the resort to our set, updates all views, and saves the change
    private func add(movie: Movie) {
        objectWillChange.send()
        favouriteMovieList.append(movie)
        save()
    }
    
    // removes the resort from our set, updates all views, and saves the change
    private func remove(movie: Movie) {
        objectWillChange.send()
        if let index:Int = favouriteMovieList.firstIndex(where: {$0.id == movie.id}) {
            favouriteMovieList.remove(at: index)
        }
        save()
    }
    
    func save() {
        // write out our data
        //UserDefaults.standard.set(favouriteMovieList, forKey: favKey)
        if let encodedList = try? JSONEncoder().encode(favouriteMovieList) {
           UserDefaults.standard.set(encodedList, forKey: favKey)
        }
    }
}
