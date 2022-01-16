//
//  MovieDetailView.swift
//  Movie
//
//  Created by Grace Liaw on 16/1/22.
//

import SwiftUI

struct MovieDetailView: View {
    @EnvironmentObject var favVM: FavouritesViewModel

    let movie: Movie
    
    var body: some View {
        ScrollView {
            AsyncImage(url: movie.backgroundURL) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }.aspectRatio(16/9, contentMode: .fit)

            Group {
                HStack {
                    Text(movie.title ?? "")
                        .font(.title)
                        .multilineTextAlignment(.center)
                }

                HStack {
                    Text("Release Date: \(movie.releaseDate ?? "")")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                HStack {
                    Text("Popularity: \(movie.popularityDisplay)")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)

                Divider()
                    .padding(.top, 10)
                    .padding(.bottom, 10)

                Text(movie.overview ?? "")
            }
            .padding(.leading, 20)
            .padding(.trailing, 20)
            
        }
        .navigationTitle(movie.title ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            FavouriteButton(movie: movie, isSet: favVM.contains(movie: movie))
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            MovieDetailView(movie: Movie(id: 1, title: "Title", overview: "Movie Description", backdropPath: "", posterPath: "", popularity: 10.0, releaseDate: "", voteAverage: 10.0, voteCount: 5))
                .preferredColorScheme($0)
                .environmentObject(FavouritesViewModel())
        }
    }
}
