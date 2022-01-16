//
//  FavouritesView.swift
//  Movie
//
//  Created by Grace Liaw on 16/1/22.
//

import SwiftUI

struct FavouritesView: View {
    @EnvironmentObject var favVM: FavouritesViewModel
    private var gridItemLayout: [GridItem] =
             Array(repeating: .init(.flexible()), count: 2)

    var body: some View {
        NavigationView {
             ScrollView {
                 LazyVGrid(columns: gridItemLayout, spacing: 20) {
                     ForEach(favVM.favouriteMovieList) { movie in
                         NavigationLink(destination: MovieDetailView(movie: movie)) {
                             MovieItem(movie: movie)
                         }
                     }
                 }
             }
            .navigationTitle("Favourites")
        }
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            FavouritesView()
                .environmentObject(FavouritesViewModel())
                .preferredColorScheme($0)
        }
    }
}
