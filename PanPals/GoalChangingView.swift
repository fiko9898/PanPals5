import SwiftUI

struct GoalChangingView: View {
    @Binding var selectedGoal: String
    @Binding var lowerGoal: Int
    @Binding var upperGoal: Int
    @Binding var isLoggedIn: Bool
    @Binding var username: String
    @EnvironmentObject var postsManager: PostsManager
    @Binding var isChangingGoal: Bool

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
                .onChange(of: selectedGoal) { _ in
                    updateGoalBounds()
                }
                
                Button(action: {
                    print("Selected goal: \(selectedGoal)")
                    updateGoalBounds()
                    self.isChangingGoal = false
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

                Spacer()
            }
            .padding()
        }
        .navigationBarTitle("Change Your Goal", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            print("GoalChangingView appeared with selectedGoal: \(selectedGoal)")
            validateSelectedGoal()
        }
    }

    private func validateSelectedGoal() {
        if !goals.contains(selectedGoal) {
            selectedGoal = goals.first ?? "Cook 1-7 meals per week"
            lowerGoal = 1
            upperGoal = 7
            print("Selected goal is invalid. Defaulting to: \(selectedGoal)")
        }
    }

    private func updateGoalBounds() {
        switch selectedGoal {
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
        print("Updated goal range: \(lowerGoal)-\(upperGoal)")
    }
}

struct GoalChangingView_Previews: PreviewProvider {
    @State static private var selectedGoal = "Cook 1-7 meals per week"
    @State static private var isLoggedIn = true
    @State static private var username = "TestUser"
    @State static private var lowerGoal = 1
    @State static private var upperGoal = 7
    @State static private var isChangingGoal = false

    static var previews: some View {
        NavigationView {
            GoalChangingView(selectedGoal: $selectedGoal, lowerGoal: $lowerGoal, upperGoal: $upperGoal, isLoggedIn: $isLoggedIn, username: $username, isChangingGoal: $isChangingGoal)
                .environmentObject(PostsManager())
        }
    }
}
