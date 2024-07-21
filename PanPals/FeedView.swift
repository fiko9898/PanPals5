import SwiftUI

struct FeedView: View {
    @EnvironmentObject var postsManager: PostsManager
    @State private var selectedPost: Post?
    @Binding var username: String

    var body: some View {
        NavigationView {
            List(postsManager.posts.sorted(by: { $0.timestamp > $1.timestamp })) { post in
                PostView(post: post, onLike: {
                    toggleLike(post: post)
                }, onComment: {
                    selectedPost = post
                })
                .background(
                    NavigationLink(destination: CommentingView(post: Binding(
                        get: { selectedPost ?? post },
                        set: { newValue in
                            if let newValue = newValue {
                                selectedPost = newValue
                            } else {
                                selectedPost = nil
                            }
                        }
                    ), username: $username), isActive: Binding(
                        get: { selectedPost != nil && selectedPost?.id == post.id },
                        set: { isActive in
                            if !isActive {
                                selectedPost = nil
                            }
                        }
                    )) {
                        EmptyView()
                    }
                    .hidden()
                )
                .listRowInsets(EdgeInsets()) // Ensure the list row does not have any padding
            }
            .navigationBarTitle("Feed", displayMode: .inline)
            .refreshable {
                postsManager.refreshPosts() // Add if you want to support pull-to-refresh
            }
            .listStyle(PlainListStyle()) // Ensure the list style is plain for better appearance
        }
        .onAppear {
            postsManager.refreshPosts()
        }
    }

    private func toggleLike(post: Post) {
        if let index = postsManager.posts.firstIndex(where: { $0.id == post.id }) {
            postsManager.posts[index].isLiked.toggle()
            postsManager.posts[index].likes += postsManager.posts[index].isLiked ? 1 : -1
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView(username: .constant("TestUser")).environmentObject(PostsManager())
    }
}
