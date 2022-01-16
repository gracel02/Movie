//
//  FavouriteButton.swift
//  Movie
//
//  Created by Grace Liaw on 16/1/22.
//

import SwiftUI

struct FavouriteButton: View {
    @EnvironmentObject var favVM: FavouritesViewModel
    
    let movie: Movie
    @State var isSet: Bool

    var body: some View {
        Button {
            isSet.toggle()
            favVM.toggleFavourites(movie: movie, isSet: isSet)
        } label: {
            Label("Toggle Favorite", systemImage: isSet ? "heart.fill" : "heart")
                .labelStyle(.iconOnly)
                .foregroundColor(isSet ? .red : .gray)
        }
    }
}

struct FavouriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteButton(movie: Movie(id: 1, title: "Title", overview: "Movie Description", backdropPath: "", posterPath: "", popularity: 10.0, releaseDate: "", voteAverage: 10.0, voteCount: 5), isSet: true)
    }
}
