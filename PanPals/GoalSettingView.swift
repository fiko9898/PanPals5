import SwiftUI

struct GoalSettingView: View {
    @Binding var selectedGoal: String
    @Binding var lowerGoal: Int
    @Binding var upperGoal: Int
    @Binding var isLoggedIn: Bool
    @Binding var isSignedUp: Bool
    @Binding var username: String
    @EnvironmentObject var postsManager: PostsManager
    @State private var isGoalSaved: Bool = false

    let goals = ["Cook 1-7 meals per week", "Cook 7-14 meals per week", "Cook 14-21 meals per week"]

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("What is your goal?")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .padding(.bottom, 40)
                
                Picker(selection: $selectedGoal, label: Text("Select your goal").foregroundColor(.white)) {
                    ForEach(goals, id: \.self) { goal in
                        Text(goal).tag(goal)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .foregroundColor(.white)
                .padding()
                .background(Color.gray)
                .cornerRadius(10)
                .padding(.bottom, 40)
                .onChange(of: selectedGoal) { newValue in
                    switch newValue {
                    case "Cook 1-7 meals per week":
                        lowerGoal = 1
                        upperGoal = 7
                    case "Cook 7-14 meals per week":
                        lowerGoal = 7
                        upperGoal = 14
                    case "Cook 14-21 meals per week":
                        lowerGoal = 14
                        upperGoal = 21
                    default:
                        lowerGoal = 1
                        upperGoal = 7
                    }
                }
                
                Button(action: {
                    print("Selected goal: \(selectedGoal)")
                    self.isLoggedIn = true
                    self.isGoalSaved = true
                }) {
                    Text("Save Goal")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }
                .padding(.horizontal)

                NavigationLink(
                    destination: MainView(
                        selectedGoal: $selectedGoal,
                        lowerGoal: $lowerGoal,
                        upperGoal: $upperGoal,
                        isLoggedIn: $isLoggedIn,
                        username: $username
                    ).environmentObject(postsManager),
                    isActive: $isGoalSaved
                ) {
                    EmptyView()
                }

                Spacer()
            }
            .padding()
        }
        .navigationBarTitle("Set Your Goal", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            print("GoalSettingView appeared with selectedGoal: \(selectedGoal)")
        }
    }
}

struct GoalSettingView_Previews: PreviewProvider {
    @State static private var selectedGoal = "Cook 1-7 meals per week"
    @State static private var isLoggedIn = true
    @State static private var isSignedUp = true
    @State static private var username = "TestUser"
    @State static private var lowerGoal = 1
    @State static private var upperGoal = 7

    static var previews: some View {
        //NavigationView {
            GoalSettingView(selectedGoal: $selectedGoal, lowerGoal: $lowerGoal, upperGoal: $upperGoal, isLoggedIn: $isLoggedIn, isSignedUp: $isSignedUp, username: $username)
                .environmentObject(PostsManager())
        //}
    }
}
