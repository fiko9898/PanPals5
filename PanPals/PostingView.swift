import SwiftUI

struct PostingView: View {
    @EnvironmentObject var postsManager: PostsManager
    @Binding var username: String
    @State private var caption: String = ""
    @State private var isImagePickerPresented: Bool = false
    @State private var isCameraPresented: Bool = false
    @State private var isPostSubmitted: Bool = false
    @FocusState private var isCaptionFieldFocused: Bool

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    if let image = postsManager.selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 300)
                            .cornerRadius(10)
                            .padding(.bottom, 20)
                    } else {
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(maxHeight: 300)
                            .cornerRadius(10)
                            .padding(.bottom, 20)
                            .overlay(Text("No Image Selected").foregroundColor(.gray))
                    }

                    HStack {
                        Button(action: {
                            isImagePickerPresented = true
                        }) {
                            Text("Select Photo")
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }

                        Button(action: {
                            isCameraPresented = true
                        }) {
                            Text("Take Photo")
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.bottom, 20)

                    TextField("Add a caption", text: $caption)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.bottom, 20)
                        .focused($isCaptionFieldFocused)

                    Button(action: {
                        postsManager.addPost(caption: caption, username: username)
                        print("Post submitted with image and caption.")
                        isPostSubmitted = true
                    }) {
                        Text("Submit Post")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }
                    .padding(.horizontal)
                    .disabled(postsManager.selectedImage == nil)
                }
                .padding()
                .navigationBarTitle("Create Post", displayMode: .inline)
                .sheet(isPresented: $isImagePickerPresented) {
                    ImagePicker(selectedImage: $postsManager.selectedImage)
                }
                .fullScreenCover(isPresented: $isCameraPresented) {
                    CameraView(selectedImage: $postsManager.selectedImage)
                }
                .alert(isPresented: $isPostSubmitted) {
                    Alert(
                        title: Text("Post Submitted"),
                        message: Text("Your post has been successfully submitted."),
                        dismissButton: .default(Text("OK")) {
                            caption = ""
                        }
                    )
                }
            }
            .background(Color(.systemBackground).edgesIgnoringSafeArea(.bottom))
            .onTapGesture {
                isCaptionFieldFocused = false
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct PostingView_Previews: PreviewProvider {
    static var previews: some View {
        PostingView(username: .constant("TestUser")).environmentObject(PostsManager())
    }
}
