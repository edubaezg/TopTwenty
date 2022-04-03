import Foundation

class ProductResultViewModel {
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
}
