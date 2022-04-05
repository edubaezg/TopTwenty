import Foundation
import Alamofire

// MARK: - CategoryError
enum CategoryError: Error {
    case emptyCategory
}

// MARK: - SearchResultsService
class SearchResultsService {
    // MARK: - Properties
    static let basePath = Paths.basePath.rawValue
    static let limitSearch = "8"
    
    // MARK: - Get a list of categories by a search text
    static func getCategoryPreditor(search: String, completion: @escaping (Result<[CategoryModel], CategoryError>) -> Void) {
        let url = "\(basePath)\(Paths.searchPreditor.rawValue)"
        AF.request(url, parameters: getParameters(search: search), encoding: URLEncoding.default).response {
            response in
            guard let data = response.data else {
                completion(.failure(.emptyCategory))
                return
            }
            do {
                let categoriesResponse = try JSONDecoder().decode([CategoryModel].self, from: data)
                completion(.success(categoriesResponse))
            } catch {
                completion(.failure(.emptyCategory))
            }
        }
    }
    
    static func getParameters(search: String) -> Parameters {
        ["limit": limitSearch, "q": search]
    }
}
