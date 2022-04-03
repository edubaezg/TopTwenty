import Foundation

// MARK: - TopTwentyResponse
struct TopTwentyResponse: Codable {
    let topTwentyItems: [TopTwentyItem]
    
    enum CodingKeys: String, CodingKey {
        case topTwentyItems = "content"
    }
}

// MARK: - TopTwentyItem
struct TopTwentyItem: Codable {
    let id: String
    let position: Int
    let type: String
}
