import SwiftUI
import AVKit

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct LaunchView: View {
    @State private var selectedGoal: String = "Cook 1-7 meals per"
    @State private var lowerGoal: Int = 1
    @State private var upperGoal: Int = 7
    @EnvironmentObject var postsManager: PostsManager

    var body: some View {
        NavigationView {
            ZStack {
                VideoBackgroundView()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("PanPals")
                        .font(.system(size: 48, weight: .heavy))
                        .foregroundColor(Color(red: 255 / 255, green: 99 / 255, blue: 71 / 255)) // Text color
                        .padding(.top, 70)
                        .shadow(color: Color.black.opacity(0.4), radius: 10, x: 0, y: 5) // Darker shadow for better contrast
                    
                    Spacer()

                    VStack(spacing: 20) {
                        // SIGNUP BUTTON
                        NavigationLink(destination: SignUpView(selectedGoal: $selectedGoal)) {
                            Text("Sign Up")
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color(red: 255 / 255, green: 99 / 255, blue: 71 / 255)) // Dark orange/red color
                                .foregroundColor(.white)
                                .cornerRadius(20)
                                .shadow(color: Color(red: 255 / 255, green: 99 / 255, blue: 71 / 255).opacity(0.3), radius: 5, x: 0, y: 2)
                        }
                        .padding(.horizontal)

                        // LOGIN BUTTON
                        NavigationLink(destination: LoginView()) {
                            Text("Already have an account")
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(20)
                                .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
                        }
                        .padding(.horizontal)
                    }
                    .padding(.bottom, 30)
                }
            }
        }
    }
}

struct VideoBackgroundView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        return LoopingPlayerUIView(frame: .zero)
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // No update needed
    }
}

class LoopingPlayerUIView: UIView {
    private let playerLayer = AVPlayerLayer()
    private let playerLooper: AVPlayerLooper
    private let queuePlayer: AVQueuePlayer

    override init(frame: CGRect) {
        let fileUrl = Bundle.main.url(forResource: "267-135875613", withExtension: "mov")!
        let asset = AVAsset(url: fileUrl)
        let item = AVPlayerItem(asset: asset)
        
        queuePlayer = AVQueuePlayer(playerItem: item)
        playerLooper = AVPlayerLooper(player: queuePlayer, templateItem: item)
        
        playerLayer.player = queuePlayer
        playerLayer.videoGravity = .resizeAspectFill
        
        super.init(frame: frame)
        
        layer.addSublayer(playerLayer)
        
        queuePlayer.play()
        queuePlayer.isMuted = true // Mute the video
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView().environmentObject(PostsManager())
    }
}
