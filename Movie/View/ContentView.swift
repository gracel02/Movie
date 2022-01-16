//
//  ContentView.swift
//  Movie
//
//  Created by Grace Liaw on 15/1/22.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .listing

    enum Tab {
        case listing
        case favourites
    }
    
    var body: some View {
        TabView(selection: $selection) {
            MovieListView()
                .tabItem {
                    Label("Listings", systemImage: "film")
                }
                .tag(Tab.listing)

            FavouritesView()
                .tabItem {
                    Label("Favourites", systemImage: "heart.circle")
                }
                .tag(Tab.favourites)
        }.accentColor(.teal)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
