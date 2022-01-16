//
//  MovieRow.swift
//  Movie
//
//  Created by Grace Liaw on 15/1/22.
//

import SwiftUI

struct MovieRow: View {
    var categoryName: String = ""
    var movies: [Movie] = [Movie]()
    let onScrolledAtEnd: () -> Void

    var body: some View {
        List {
            Text(categoryName)
                .font(.title3)
                .foregroundColor(.teal)
                .padding(.leading, 10)
                .padding(.top, 15)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .top, spacing: 20) {
                    ForEach(movies) { movie in
                        NavigationLink {
                            MovieDetailView(movie: movie)
                        } label: {
                            MovieItem(movie: movie)
                        }
                        .onAppear {
                            let thresholdIndex = movies.index(movies.endIndex, offsetBy: -5)
                            if movies.firstIndex(where: { $0.id == movie.id }) == thresholdIndex {
                                self.onScrolledAtEnd()
                            }
                        }
                    }
                }
            }
            .frame(height: 305)
            .listRowSeparator(.hidden)
        }
    }
}

struct MovieRow_Previews: PreviewProvider {
    static var previews: some View {
        MovieRow(
            categoryName: "Movie Category",
            movies: [Movie](),
            onScrolledAtEnd: { }
        )
    }
}
