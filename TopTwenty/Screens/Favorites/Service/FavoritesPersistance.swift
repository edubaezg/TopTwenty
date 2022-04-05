import Foundation

// MARK: - FavoritesPersistance
class FavoritesPersistance {
    // MARK: - Singlenton
    static let userDefaults = UserDefaults.standard
    
    // Add a new favorite item id in memory 
    static func addFavorite(productId: String) {
        var productIds: [String] = userDefaults.object(forKey: "favorites") as? [String] ?? []
        productIds.append(productId)
        userDefaults.set(productIds, forKey: "favorites")
    }
    
    // Get list of favorites products in memory
    static func getFavorites(completion: ([String]) -> Void) {
        let productIds: [String] = userDefaults.object(forKey: "favorites") as? [String] ?? []
        completion(productIds)
    }
    
    // Delete a favorite item in memory
    static func deleteFavorite(productId: String) {
        let productIds: [String] = userDefaults.object(forKey: "favorites") as? [String] ?? []
        let productIdsFiltered = productIds.filter { id in id != productId }
        userDefaults.set(productIdsFiltered, forKey: "favorites")
    }
    
}
