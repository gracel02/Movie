//
//  MovieApp.swift
//  Movie
//
//  Created by Grace Liaw on 15/1/22.
//

import SwiftUI

@main
struct MovieApp: App {
    //share state of FavouritesViewModel to get access of the Favourites list across the app
    @StateObject var favVM = FavouritesViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(favVM)
        }
    }
}
