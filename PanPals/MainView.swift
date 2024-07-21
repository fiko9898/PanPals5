import SwiftUI

struct MainView: View {
    @Binding var selectedGoal: String
    @Binding var lowerGoal: Int
    @Binding var upperGoal: Int
    @Binding var isLoggedIn: Bool
    @Binding var username: String
    @State private var selectedTab = 0
    @EnvironmentObject var postsManager: PostsManager

    var body: some View {
        TabView(selection: $selectedTab) {
            FeedView(username: $username)
                .tabItem {
                    Label("Feed", systemImage: "list.dash")
                }
                .tag(0)
                .environmentObject(postsManager)
            
            PostingView(username: $username)
                .tabItem {
                    Label("Post", systemImage: "plus.circle")
                }
                .tag(1)
                .environmentObject(postsManager)
            
            MyProfileView(selectedGoal: $selectedGoal, lowerGoal: $lowerGoal, upperGoal: $upperGoal, isLoggedIn: $isLoggedIn, username: $username)
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
                .tag(2)
                .onAppear {
                    if isLoggedIn {
                        self.selectedTab = 2
                    }
                }
        }
        .navigationBarHidden(true) // Hide the navigation bar
    }
}

struct MainView_Previews: PreviewProvider {
    @State static private var selectedGoal = "Cook 1-7 meals per week"
    @State static private var isLoggedIn = true
    @State static private var username = "TestUser"
    @State static private var lowerGoal = 1
    @State static private var upperGoal = 7

    static var previews: some View {
        MainView(selectedGoal: $selectedGoal, lowerGoal: $lowerGoal, upperGoal: $upperGoal, isLoggedIn: $isLoggedIn, username: $username).environmentObject(PostsManager())
    }
}
