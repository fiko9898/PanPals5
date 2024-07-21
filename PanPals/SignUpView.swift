import SwiftUI

struct SignUpView: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isSignedUp: Bool = false
    @State private var isLoggedIn: Bool = false
    @Binding var selectedGoal: String
    @State private var lowerGoal: Int = 1
    @State private var upperGoal: Int = 7

    let defaultGoal = "Cook 1-7 meals per week" // Default valid goal

    var body: some View {
        //NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)

                VStack {
                    // Your UI elements here...
                    TextField("Username", text: $username)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.bottom, 20)

                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.bottom, 20)

                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.bottom, 40)

                    Button(action: {
                        // Handle sign up action
                        print("Sign Up button tapped with name: \(username), email: \(email), password: \(password)")
                        // Simulate sign up success
                        self.isSignedUp = true
                    }) {
                        Text("Sign Up")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }
                    .padding(.horizontal)

                    NavigationLink(
                        destination: GoalSettingView(selectedGoal: $selectedGoal, lowerGoal: $lowerGoal, upperGoal: $upperGoal, isLoggedIn: $isLoggedIn, isSignedUp: $isSignedUp, username: $username)
                            .environmentObject(PostsManager()),
                        isActive: $isSignedUp
                    ) {
                        EmptyView()
                    }
                }
                .padding()
            }
        //}
        .navigationBarTitle("Sign Up", displayMode: .inline)
        .navigationBarBackButtonHidden(false) // Ensure the back button is shown
        .onAppear {
            if !["Cook 1-7 meals per week", "Cook 7-14 meals per week", "Cook 14-21 meals per week"].contains(selectedGoal) {
                selectedGoal = defaultGoal
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    @State static private var selectedGoal = "Cook 1-7 meals per week"

    static var previews: some View {
        NavigationView {
            SignUpView(selectedGoal: $selectedGoal)
        }
    }
}
