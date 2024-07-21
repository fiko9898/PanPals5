import SwiftUI

struct CommentingView: View {
    @EnvironmentObject var postsManager: PostsManager
    @Binding var post: Post?
    @Binding var username: String

    @State private var newComment: String = ""
    @FocusState private var isCommentFieldFocused: Bool
    @State private var localPost: Post

    init(post: Binding<Post?>, username: Binding<String>) {
        self._post = post
        self._username = username
        self._localPost = State(initialValue: post.wrappedValue ?? Post(image: UIImage(), caption: "", username: ""))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let _ = post {
                Image(uiImage: localPost.image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: UIScreen.main.bounds.width - 32)
                    .cornerRadius(10)
                    .padding(.bottom, 10)

                Text(localPost.caption)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Divider()

                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(localPost.commentsArray, id: \.self) { comment in
                            Text("\(comment)")
                                .font(.body)
                                .foregroundColor(.primary)
                                .padding(.vertical, 4)
                                .padding(.horizontal, 8)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                        }
                    }
                }
                
                HStack {
                    TextField("Add a comment...", text: $newComment)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .focused($isCommentFieldFocused)
                    
                    Button(action: {
                        addComment()
                    }) {
                        Text("Post")
                            .font(.headline)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding(.top, 10)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 2)
        .padding(.horizontal, 20)
        .onAppear {
            DispatchQueue.main.async {
                self.isCommentFieldFocused = true
            }
        }
        .onDisappear {
            if post != nil {
                postsManager.updatePost(localPost)
            }
        }
    }

    private func addComment() {
        guard !newComment.isEmpty else { return }
        localPost.commentsArray.append("\(username): \(newComment)")
        newComment = ""
        isCommentFieldFocused = false
    }
}
