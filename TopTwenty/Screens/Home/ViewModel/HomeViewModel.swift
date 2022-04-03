import Foundation

class HomeViewModel {
    let homePersistance = HomePersistance()
    
    func getAccessToken(completion: @escaping (Bool) -> Void) {
        HomeService.getAccessToken { result in
            switch result {
            case .success(let accessToken):
                self.homePersistance.saveToken(token: accessToken)
                completion(true)
            case .failure(_):
                completion(false)
            }
        }
    }
}
