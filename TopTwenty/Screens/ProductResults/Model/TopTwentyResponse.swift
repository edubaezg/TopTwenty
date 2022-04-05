import Foundation

// MARK: - Protocols
protocol Itemeable {
    var id: String { get }
    var position: Int { get }
    var type: String { get }
}

// MARK: - TopTwentyResponse
struct TopTwentyResponse: Codable {
    let topTwentyItems: [TopTwentyItem]
    
    enum CodingKeys: String, CodingKey {
        case topTwentyItems = "content"
    }
}

// MARK: - TopTwentyItem
struct TopTwentyItem: Itemeable, Codable {
    let id: String
    let position: Int
    let type: String
}
