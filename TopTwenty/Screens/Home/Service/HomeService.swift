import Foundation
import Alamofire

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
                    completion(.success(loginResponse.access_token))
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
            "grant_type": "authorization_code",
            "client_id": "917558775959455",
            "client_secret": "tYlWPS728XrVRkyGz9PYAyo7cU2QaFe3",
            "code": "TG-62474bc60d0811001a2613d0-9754121",
            "redirect_uri": "https://google.com"
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
