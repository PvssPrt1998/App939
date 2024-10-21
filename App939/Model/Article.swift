import Foundation

struct Article: Hashable {
    let id: UUID
    let image: Data
    let name: String
    let description: String
}
