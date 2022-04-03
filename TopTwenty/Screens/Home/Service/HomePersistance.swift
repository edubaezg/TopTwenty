import Foundation

class HomePersistance {
    func saveToken(token: String) {
        UserDefaults.standard.set(token, forKey: "token")
    }
    
    static func getToken() -> String? {
        guard let token = UserDefaults.standard.string(forKey: "token") else { return nil }
        return token
    }
}
