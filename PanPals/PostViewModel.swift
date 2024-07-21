//
//  PostViewModel.swift
//  PanPals
//
//  Created by Fiko on 18.07.2024.
//

import Foundation
import SwiftUI

class PostViewModel: ObservableObject, Identifiable {
    @Published var post: Post
    
    init(post: Post) {
        self.post = post
    }
    
    func toggleLike() {
        post.isLiked.toggle()
        post.likes += post.isLiked ? 1 : -1
    }
}
