import Foundation
import Alamofire

// MARK: - HomeService
class HomeService {
    static let basePath = Paths.basePath.rawValue
    
    static func getAccessToken(completion: @escaping (Result<String, HttpError>) -> Void) {
        let url = "\(basePath)\(Paths.accessToken.rawValue)"
        AF.request(url, method: .post, parameters: getParams(), encoding: JSONEncoding.default, headers: getHeaders()).response { response in
            
            guard let data = response.data, let status = response.response?.statusCode else {
                completion(.failure(.badRequest))
                return
            }
            
            do {
                switch status {
                case StatucCodes.OK.rawValue:
                    let loginResponse = try JSONDecoder().decode(LoginResponseModel.self, from: data)
                    completion(.success(loginResponse.accessToken))
                case StatucCodes.BAD_REQUEST.rawValue:
                    completion(.failure(.badRequest))
                default:
                    completion(.failure(.badRequest))
                }
            } catch {
                completion(.failure(.badRequest))
            }
        }
    }
    
    static func getParams() -> Parameters {
        let params : Parameters = [
            "grant_type": AuthConfig.grantType.rawValue,
            "client_id": AuthConfig.clientId.rawValue,
            "client_secret": AuthConfig.clientSecret.rawValue,
            "code": AuthConfig.code.rawValue,
            "redirect_uri": AuthConfig.redirectUri.rawValue
        ]
        
        return params
    }
    
    static func getHeaders() -> HTTPHeaders {
        let headers : HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type":"application/x-www-form-urlencoded"
        ]
        
        return headers
    }
    
}
