//
//  MovieItem.swift
//  Movie
//
//  Created by Grace Liaw on 15/1/22.
//

import SwiftUI

struct MovieItem: View {
    let movie: Movie

    var body: some View {
        VStack(alignment: .center) {
            AsyncImage(url: movie.posterURL) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 150, height: 225)
            Text(movie.title ?? "").font(.headline)//.foregroundColor(.secondary)
        }.frame(width: 150, height: 305 , alignment: .top)
    }
}

struct MovieItem_Previews: PreviewProvider {
    static var previews: some View {
        MovieItem(movie: Movie(id: 1, title: "Title", overview: "Movie Description", backdropPath: "", posterPath: "", popularity: 10.0, releaseDate: "", voteAverage: 10.0, voteCount: 5))
    }
}
