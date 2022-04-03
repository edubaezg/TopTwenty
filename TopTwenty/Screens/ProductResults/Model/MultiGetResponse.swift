import Foundation

// MARK: - MultiGetResponse
struct MultiGetResponse: Codable {
    let body: Product
}

// MARK: - Product
struct Product: Codable {
    let id, title, thumbnail: String
    let warranty: String?
    let price: Double
    let pictures: [Picture]
}

// MARK: - Picture
struct Picture: Codable {
    let url: String
}
