import Foundation

// MARK: - Protocols
protocol Productable {
    var id: String { get }
    var title: String { get }
    var thumbnail: String { get }
    var warranty: String? { get }
    var price: Double { get }
    var pictures: [Picture] { get }
    var isFavorite: Bool? { get }
}

// MARK: - MultiGetResponse
struct MultiGetResponse: Codable {
    let body: Product
}

// MARK: - Product
struct Product: Productable, Codable {
    let id, title, thumbnail: String
    let warranty: String?
    let price: Double
    let pictures: [Picture]
    let condition: String?
    var isFavorite: Bool?
}

// MARK: - Picture
struct Picture: Codable {
    let url: String
}
