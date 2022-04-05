import Foundation

// MARK: - Protocol
protocol Categorable {
    var categoryId: String { get }
    var domainName: String { get }
}

// MARK: - CategoryModel
struct CategoryModel: Categorable, Codable {
    let categoryId: String
    let domainName: String
    
    enum CodingKeys: String, CodingKey {
        case categoryId = "category_id"
        case domainName = "domain_name"
    }
}
