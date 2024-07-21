//
//  ContentView.swift
//  PanPals
//
//  Created by Fiko on 7.07.2024.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("selectedGoal") private var selectedGoal: String = "Cook 1-7 meals per week"
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = true
    
    var body: some View {
        LaunchView().environmentObject(PostsManager())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(PostsManager())
    }
}
