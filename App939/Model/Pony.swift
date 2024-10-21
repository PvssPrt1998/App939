import Foundation

struct Pony: Hashable {
    let ponyId: UUID
    var ponyImageData: Data
    var name: String
    var breed: String
    var age: String
    var color: String
    var height: String
    var weight: String
    var personality: String
}
