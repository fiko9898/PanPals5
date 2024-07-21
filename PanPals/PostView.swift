import SwiftUI

struct PostView: View {
    let post: Post
    let onLike: () -> Void
    let onComment: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(post.username) // Display username at the top
                .font(.headline)
                .padding(.horizontal, 15)
            
            // Image
            Image(uiImage: post.image)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: 300)
                .clipped()

            // Operations menu
            HStack {
                Button(action: onLike) {
                    Image(systemName: post.isLiked ? "heart.fill" : "heart")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .padding(5)
                        .padding(.leading, 10)
                }
                .buttonStyle(PlainButtonStyle()) // Ensure it is a plain button

                Button(action: onComment) {
                    Image(systemName: "bubble.right")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .padding(5)
                }
                .buttonStyle(PlainButtonStyle()) // Ensure it is a plain button

                Spacer()
            }
            .frame(height: 20)

            VStack(alignment: .leading, spacing: 0) {
                Group {
                    Text(post.caption)
                        .font(Font.system(size: 14))
                }
                .padding(.horizontal, 15)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Text("\(post.likes) likes")
                .font(Font.system(size: 14, weight: .semibold))
                .padding(.horizontal, 15)
                .padding(.vertical, 6)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text(post.timeAgo)
                .font(Font.system(size: 12))
                .foregroundColor(.gray)
                .padding(.horizontal, 15)
                .padding(.bottom, 10)
        }
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 2)
        .padding(.horizontal, 10)
        .contentShape(Rectangle()) // Ensure the whole VStack has a defined tappable area
        .onTapGesture {
            // Do nothing when the whole frame is tapped
        }
    }
}
