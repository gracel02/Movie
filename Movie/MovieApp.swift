//
//  MovieApp.swift
//  Movie
//
//  Created by Grace Liaw on 15/1/22.
//

import SwiftUI

@main
struct MovieApp: App {
    @StateObject var favVM = FavouritesViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(favVM)
        }
    }
}
