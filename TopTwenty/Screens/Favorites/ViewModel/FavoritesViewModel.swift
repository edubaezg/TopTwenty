import Foundation

// MARK: - FavoritesViewModel
class FavoritesViewModel {
    // Get list of favorites products in memory
    func getFavorites(currentProducts: Int, completion: @escaping ([Product]?) -> Void) {
        FavoritesPersistance.getFavorites { productIds in
            if productIds.count == 0 {
                completion([Product]())
            } else if currentProducts == productIds.count {
                completion(nil)
            } else {
                getProducts(productIds: productIds, completion: completion)
            }
        }
    }
    
    // Get list of products by favorite ids
    private func getProducts(productIds: [String], completion: @escaping ([Product]) -> Void) {
        let productIdsString = ProductResultService.getProductIds(products: productIds)
        ProductResultService.getMultiGet(withItems: productIdsString) { result in
            switch result {
            case .success(let products):
                completion(products)
            case .failure(_):
                print("error getproducts")
            }
        }
    }
    
    // Delete a favorite item in memory
    func deleteFavorite(productId: String) {
        FavoritesPersistance.deleteFavorite(productId: productId)
    }
}
