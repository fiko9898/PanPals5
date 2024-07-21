import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn: Bool = false
    @State private var selectedGoal: String = "Cook 1-7 meals per week" // Provide a default goal
    @State private var isSignedUp: Bool = true
    @State private var lowerGoal: Int = 1
    @State private var upperGoal: Int = 7
    @State private var username: String = "TestUser" // Simulate user login

    var body: some View {
        if isLoggedIn && isSignedUp {
            MainView(selectedGoal: $selectedGoal, lowerGoal: $lowerGoal, upperGoal: $upperGoal, isLoggedIn: $isLoggedIn, username: $username)
        } else {
            ZStack {
                // Background color
                Color.black.edgesIgnoringSafeArea(.all)

                VStack {
                    // Login Text
                    Text("Welcome Back")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(Color.white)
                        .padding(.bottom, 40)

                    Text("Let's get started by filling out the form below.")
                        .font(.subheadline)
                        .fontWeight(.heavy)
                        .foregroundColor(Color.white)
                        .padding(.bottom, 40)

                    // Email Field
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color.gray)
                        .cornerRadius(10)
                        .padding(.bottom, 20)

                    // Password Field
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.gray)
                        .cornerRadius(10)
                        .padding(.bottom, 40)

                    // Log In Button
                    Button(action: {
                        // Handle log in action
                        print("Log In button tapped with email: \(email), password: \(password)")
                        // Simulate successful login
                        self.isLoggedIn = true
                    }) {
                        Text("Sign In")
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
            .navigationBarTitle("Login", displayMode: .inline)
            .navigationBarBackButtonHidden(false) // Ensure the back button is shown
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginView()
        }
    }
}
