import Foundation

// MARK: - Protocol
protocol Favoritable {
    var id: String { get }
    var createdAt: Date { get }
}

// MARK: - Favorite Model
struct FavoriteModel: Favoritable {
    let id: String
    let createdAt: Date
}
