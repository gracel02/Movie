//
//  MovieListView.swift
//  Movie
//
//  Created by Grace Liaw on 15/1/22.
//

import SwiftUI

struct MovieListView: View {
    @ObservedObject var movieListVM = MovieListViewModel()
    @EnvironmentObject var favVM: FavouritesViewModel

    var body: some View {
        NavigationView {
            Form {
                Section()
                {
                    MovieRow(categoryName: "Popular", movies: movieListVM.popularMovieList, onScrolledAtEnd: movieListVM.getPopularMovies)
                }
                Section()
                {
                    MovieRow(categoryName: "Upcoming", movies: movieListVM.upcomingMovieList, onScrolledAtEnd: movieListVM.getUpcomingMovies)
                }
            }
            .listStyle(GroupedListStyle())

            .navigationTitle("Movies")
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            MovieListView()
                .preferredColorScheme($0)
                .environmentObject(FavouritesViewModel())
        }
    }
}

