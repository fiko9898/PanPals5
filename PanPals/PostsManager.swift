import SwiftUI

class PostsManager: ObservableObject {
    @Published var posts: [Post] = [
        Post(id: UUID(), image: UIImage(named: "PanPalsLogo")!, caption: "First post", timestamp: Date(), username: "User1", likes: 5, commentsArray: ["User2: Great post!", "User3: Nice!"]),
        Post(id: UUID(), image: UIImage(named: "PanPalsLogo 2")!, caption: "Second post", timestamp: Date(), username: "User2", likes: 3, commentsArray: ["User1: Cool picture!"]),
        Post(id: UUID(), image: UIImage(named: "PanPalsLogo 3")!, caption: "Third post", timestamp: Date(), username: "User3", likes: 7, commentsArray: ["User1: Amazing!", "User2: Wow!", "User3: Beautiful!"])
    ]
    @Published var selectedImage: UIImage? = nil
    
    func addPost(caption: String, username: String) {
        guard let image = selectedImage else {
            print("No image selected")
            return
        }
        
        let newPost = Post(id: UUID(), image: image, caption: caption, timestamp: Date(), username: username)
        posts.append(newPost)
        sortPosts()
        selectedImage = nil // Reset selectedImage after posting
    }
    
    func refreshPosts() {
        sortPosts()
    }
    
    private func sortPosts() {
        posts.sort { $0.timestamp > $1.timestamp }
    }
    
    func toggleLike(post: Post) {
        if let index = posts.firstIndex(where: { $0.id == post.id }) {
            posts[index].isLiked.toggle()
            posts[index].likes += posts[index].isLiked ? 1 : -1
        }
    }
    
    func addComment(to post: Post, comment: String) {
        if let index = posts.firstIndex(where: { $0.id == post.id }) {
            posts[index].commentsArray.append(comment)
        }
    }

    func updatePost(_ post: Post) {
        if let index = posts.firstIndex(where: { $0.id == post.id }) {
            posts[index] = post
        }
    }
}
