import Foundation

// MARK: - ProductResultViewModel
class ProductResultViewModel {
    // Get a list of products by category id
    func getTopTwenty(withCategoryId categoryId: String, completion: @escaping ([Product]) -> Void) {
        ProductResultService.getTopTwenty(withCategoryId: categoryId) { result in
            switch result {
            case .success(let products):
                completion(products)
            case .failure(_):
                print("error products")
            }
        }
    }
    
    // Add a new favorite item id in memory
    func addFavorite(productId: String) {
        FavoritesPersistance.addFavorite(productId: productId)
    }
    
    // Delete a favorite item in memory
    func deleteFavorite(productId: String) {
        FavoritesPersistance.deleteFavorite(productId: productId)
    }
}
