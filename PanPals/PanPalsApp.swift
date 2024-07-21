//
//  PanPalsApp.swift
//  PanPals
//
//  Created by Fiko on 7.07.2024.
//
//AAAAAAAAAa
import SwiftUI

@main
struct PanPalsApp: App {
    @StateObject private var postsManager = PostsManager()

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(postsManager)
        }
    }
}
