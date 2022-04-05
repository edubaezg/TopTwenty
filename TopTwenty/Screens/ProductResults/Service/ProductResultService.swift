import Foundation
import Alamofire

// MARK: - ProductResultService
class ProductResultService {
    // MARK: - Properties
    static let basePath = Paths.basePath.rawValue
    
    // Get top 20 products by category
    static func getTopTwenty(withCategoryId categoryId: String, completion: @escaping (Result<[Product], Error>) -> Void) {
        let url = "\(basePath)\(Paths.topTwenty.rawValue)\(categoryId)"
        AF.request(url, encoding: URLEncoding.default, headers: getHeaders()).response {
            response in
            guard let data = response.data else { return }
            do {
                let topTwentyResponse = try JSONDecoder().decode(TopTwentyResponse.self, from: data)
                let productIds = topTwentyResponse.topTwentyItems.map { $0.id }
                let productIdsString = getProductIds(products: productIds)
                getMultiGet(withItems: productIdsString, completion: completion)
            } catch {
                print("Error getTopTwenty: \(error.localizedDescription)")
            }
        }
    }
    
    // Get product detail by multiple product ids
    static func getMultiGet(withItems productsIds: String, completion: @escaping (Result<[Product], Error>) -> Void) {
        let url = "\(basePath)\(Paths.multiget.rawValue)"
        AF.request(url, parameters: getParameters(productsIds: productsIds), encoding: URLEncoding.default, headers: getHeaders()).response {
            response in
            guard let data = response.data else { return }
            do {
                let multiGetResponse = try JSONDecoder().decode([MultiGetResponse].self, from: data)
                var products = multiGetResponse.map { response in response.body }
                setProductFavorites(products: &products, completion: completion)
            } catch {
                print("Error getMultiGet: \(error.localizedDescription)")
            }
        }
    }
    
    private static func getHeaders() -> HTTPHeaders {
        guard let token = HomePersistance.getToken() else { return HTTPHeaders() }
        return ["Authorization": "Bearer \(token)"]
    }
    
    private static func getParameters(productsIds: String) -> Parameters {
        ["ids": productsIds]
    }
    
    // Get a string of ids by an array of strings
    static func getProductIds(products: [String]) -> String {
        var productIds = ""
        products.forEach { item in productIds.append(item + ",") }
        return productIds
    }
    
    // Set product like favorite if is in memory and return products updated to view model
    private static func setProductFavorites(products: inout [Product], completion: @escaping (Result<[Product], Error>) -> Void) {
        for index in 0..<products.count {
            FavoritesPersistance.getFavorites { productIds in
                let favoriteProducts = productIds.filter { id in id == products[index].id }
                products[index].isFavorite = favoriteProducts.count > 0
            }
        }
        
        completion(.success(products))
    }
    
}
