import Foundation

class SearchResultsViewModel {
    func getCategoryPreditor(search: String, completion: @escaping ([CategoryModel]) -> Void) {
        
        let searchFormatted = search.lowercased().trimmingLeadingAndTrailingSpaces()
        
        SearchResultsService.getCategoryPreditor(search: searchFormatted) { result in
            switch result {
            case .success(let categories):
                completion(categories)
            case .failure(_):
                completion([])
            }
        }
    }
}
