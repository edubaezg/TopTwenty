import Foundation

// MARK: - Protocol
protocol Logeable {
    var accessToken: String { get }
}

// MARK: - LoginResponseModel
struct LoginResponseModel: Logeable, Codable {
    let accessToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
    }
}
