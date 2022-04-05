import Foundation

// MARK: - ProductDetailViewModel
class ProductDetailViewModel {
    // Add a new favorite item id in memory
    func addFavorite(productId: String) {
        FavoritesPersistance.addFavorite(productId: productId)
    }
    
    // Delete a favorite item in memory
    func deleteFavorite(productId: String) {
        FavoritesPersistance.deleteFavorite(productId: productId)
    }
}
