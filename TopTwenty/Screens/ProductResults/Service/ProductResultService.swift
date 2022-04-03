import Foundation
import Alamofire

class ProductResultService {
    static func getTopTwenty(withCategoryId categoryId: String, completion: @escaping (Result<[Product], Error>) -> Void) {
        AF.request("https://api.mercadolibre.com/highlights/MLM/category/\(categoryId)", encoding: URLEncoding.default, headers: getHeaders()).response {
            response in
            guard let data = response.data else { return }
            do {
                let topTwentyResponse = try JSONDecoder().decode(TopTwentyResponse.self, from: data)
                getMultiGet(withItems: topTwentyResponse.topTwentyItems, completion: completion)
            } catch {
                print("Error getTopTwenty")
            }
        }
    }
    
    private static func getMultiGet(withItems topTwentyItems: [TopTwentyItem], completion: @escaping (Result<[Product], Error>) -> Void) {
        AF.request("https://api.mercadolibre.com/items", parameters: getParameters(topTwentyItems: topTwentyItems), encoding: URLEncoding.default, headers: getHeaders()).response {
            response in
            guard let data = response.data else { return }
            do {
                let multiGetResponse = try JSONDecoder().decode([MultiGetResponse].self, from: data)
                let products = multiGetResponse.map { response in response.body }
                completion(.success(products))
            } catch {
                print("Error getMultiGet")
            }
        }
    }
    
    private static func getHeaders() -> HTTPHeaders {
        ["Authorization": "Bearer APP_USR-917558775959455-040318-c7e294745e9ae1dfb3048b0437f4268a-9754121"]
    }
    
    private static func getParameters(topTwentyItems: [TopTwentyItem]) -> Parameters {
        var contentIds = ""
        
        topTwentyItems.forEach { item in
            contentIds.append(item.id + ",")
        }
        
        print(contentIds)
        
        let params = [ "ids": contentIds ]
        
        return params
    }
}
