//
//  MovieItem.swift
//  Movie
//
//  Created by Grace Liaw on 15/1/22.
//

import SwiftUI

struct MovieItem: View {
    @ObservedObject var imageLoader = ImageLoader()
    let movie: Movie
    
    var body: some View {
        VStack(alignment: .center) {
            if self.imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
                    .frame(width: 150, height: 225)
                
            }else{
                Image(uiImage: UIImage(named: "placeholder.png")!)
                    .resizable()
                    .frame(width: 150, height: 225)
            }

            Text(movie.title ?? "").font(.headline)
        }
        .onAppear {
            self.imageLoader.loadImage(with: movie.posterURL)
        }
        .frame(width: 150, height: 305 , alignment: .top)
        
    }
}

struct MovieItem_Previews: PreviewProvider {
    static var previews: some View {
        MovieItem(movie: Movie(id: 1, title: "Title", overview: "Movie Description", backdropPath: "", posterPath: "", popularity: 10.0, releaseDate: "", voteAverage: 10.0, voteCount: 5))
    }
}
