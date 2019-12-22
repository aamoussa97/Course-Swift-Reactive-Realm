import Alamofire
import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    var manager: SessionManager
    
    private init() {
        self.manager = Alamofire.SessionManager(configuration: URLSessionConfiguration.default)
    }
    
    static func getApiComponents(path: String, queryItems: [URLQueryItem]?) -> URLComponents {
        var urlComponents = URLComponents()
        
        let baseUrl = URL(string: "https://demo.overallapps.com")!
        
        urlComponents.scheme = baseUrl.scheme!
        urlComponents.host = baseUrl.host!
        urlComponents.port = baseUrl.port
        urlComponents.path = "\(baseUrl.path)\(path)"
        urlComponents.queryItems = queryItems
        
        return urlComponents
    }
}
