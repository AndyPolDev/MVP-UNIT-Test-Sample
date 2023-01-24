import UIKit

struct CommentsModel: Decodable {
    let comments: [Comment]
}

struct Comment: Decodable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}
