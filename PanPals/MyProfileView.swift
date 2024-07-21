import SwiftUI

struct MyProfileView: View {
    @Binding var selectedGoal: String
    @Binding var lowerGoal: Int
    @Binding var upperGoal: Int
    @Binding var isLoggedIn: Bool
    @Binding var username: String
    @EnvironmentObject var postsManager: PostsManager
    @State private var selectedPost: Post? = nil
    @State private var isChangingGoal: Bool = false

    private var userPosts: [Post] {
        postsManager.posts.filter { $0.username == username }
    }

    var body: some View {
        NavigationView {
            VStack {
                Text("Selected Goal: \(selectedGoal)")
                
                Button(action: {
                    isChangingGoal = true
                }) {
                    Text("Change Goal")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }
                .padding(.horizontal)

                GoalBarView(goalRange: lowerGoal...upperGoal, currentProgress: userPosts.count)
                    .padding()

                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 10) {
                        ForEach(userPosts) { post in
                            Image(uiImage: post.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipped()
                                .cornerRadius(10)
                                .onTapGesture {
                                    selectedPost = post
                                }
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
                        }
                    }
                    .padding()
                }

                Spacer()
            }
            .navigationBarTitle("My Profile", displayMode: .inline)
            .background(
                NavigationLink(
                    destination: GoalChangingView(
                        selectedGoal: $selectedGoal,
                        lowerGoal: $lowerGoal,
                        upperGoal: $upperGoal,
                        isLoggedIn: $isLoggedIn,
                        username: $username,
                        isChangingGoal: $isChangingGoal
                    ).environmentObject(postsManager),
                    isActive: $isChangingGoal
                ) {
                    EmptyView()
                }
            )
        }
        .onAppear {
            isChangingGoal = false
        }
    }
}

struct MyProfileView_Previews: PreviewProvider {
    @State static private var selectedGoal = "Cook 1-7 meals per week"
    @State static private var isLoggedIn = true
    @State static private var username = "TestUser"
    @State static private var lowerGoal = 1
    @State static private var upperGoal = 7

    static var previews: some View {
        MyProfileView(
            selectedGoal: $selectedGoal,
            lowerGoal: $lowerGoal,
            upperGoal: $upperGoal,
            isLoggedIn: $isLoggedIn,
            username: $username
        ).environmentObject(PostsManager())
    }
}
