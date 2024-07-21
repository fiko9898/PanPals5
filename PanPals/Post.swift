import Foundation
import SwiftUI

struct Post: Identifiable {
    let id: UUID
    let image: UIImage
    let caption: String
    let timestamp: Date
    let username: String
    var likes: Int
    var commentsArray: [String]
    var isLiked: Bool

    init(id: UUID = UUID(), image: UIImage, caption: String, timestamp: Date = Date(), username: String, likes: Int = 0, commentsArray: [String] = [], isLiked: Bool = false) {
        self.id = id
        self.image = image
        self.caption = caption
        self.timestamp = timestamp
        self.username = username
        self.likes = likes
        self.commentsArray = commentsArray
        self.isLiked = isLiked
    }

    var timeAgo: String {
        let timeInterval = Date().timeIntervalSince(timestamp)
        let minutes = Int(timeInterval / 60)
        let hours = minutes / 60

        if hours > 0 {
            return "\(hours) hours ago"
        } else {
            return "\(minutes) minutes ago"
        }
    }

    var comments: Int {
        return commentsArray.count
    }
}
