import Alamofire
import RealmSwift
import RxAlamofire
import RxSwift
import SwiftyJSON

class PersonsAPI {
    
    // Fetch persons from server - Own extra 1
    class func fetchPersonsFromServer() -> Observable<JSON> {
        let urlComponents = NetworkManager.getApiComponents(path: "/persons", queryItems: nil)
        
        let manager = NetworkManager.shared.manager
        return manager.rx.request(.get, urlComponents.url!, parameters: nil, encoding: JSONEncoding.default, headers: ["x-api-key": Constants.apiKey])
            .flatMap {
                $0
                    .validate(statusCode: 200 ..< 300)
                    .validate(contentType: ["application/json"])
                    .rx.json()
        }
        .map { data in
            return JSON(data)
        }
    }
    
    // Fetch persons from server, with error code message alert, Error 401 - Exercise: 3e-401
    class func fetchPersonsFromServerWithErrorCode401() -> Observable<JSON> {
        let urlComponents = NetworkManager.getApiComponents(path: "/persons", queryItems: nil)
        
        let manager = NetworkManager.shared.manager
        return manager.rx.request(.get, urlComponents.url!, parameters: nil, encoding: JSONEncoding.default, headers: ["x-api-key": ""])
            .flatMap {
                $0
                    .validate(statusCode: 200 ..< 300)
                    .validate(contentType: ["application/json"])
                    .rx.json()
        }
        .map { data in
            return JSON(data)
        }
    }
    
    // Fetch persons from server, with error code message alert, Error 404 - Exercise: 3e-404
    class func fetchPersonsFromServerWithErrorCode404() -> Observable<JSON> {
        let urlComponents = NetworkManager.getApiComponents(path: "/persons$", queryItems: nil)
        
        let manager = NetworkManager.shared.manager
        return manager.rx.request(.get, urlComponents.url!, parameters: nil, encoding: JSONEncoding.default, headers: ["x-api-key": Constants.apiKey])
            .flatMap {
                $0
                    .validate(statusCode: 200 ..< 300)
                    .validate(contentType: ["application/json"])
                    .rx.json()
        }
        .map { data in
            return JSON(data)
        }
    }
    
    // PUT - Exercise: 3a
    class func put(personIDToPut: String, changeNewPersonFirstName: String, changeNewPersonLastName: String, changeNewPersonAge: Int) -> Observable<JSON> {
        let urlComponents = NetworkManager.getApiComponents(path: "/persons/\(personIDToPut)", queryItems: nil)
        
        let parameters: [String: Any] = [
            "firstName": changeNewPersonFirstName,
            "lastName": changeNewPersonLastName,
            "age": changeNewPersonAge
        ]
        
        let manager = NetworkManager.shared.manager
        return manager.rx.request(.put, urlComponents.url!, parameters: parameters, encoding: JSONEncoding.default, headers: ["x-api-key": Constants.apiKey])
            .flatMap {
                $0
                    .validate(statusCode: 200 ..< 300)
                    .validate(contentType: ["application/json"])
                    .rx.json()
        }
        .map { data in
            return JSON(data)
        }
    }
    
    // POST - Exercise: 3b
    class func post(newPersonFirstName: String, newPersonLastName: String, newPersonAge: Int) -> Observable<JSON> {
        let urlComponents = NetworkManager.getApiComponents(path: "/persons", queryItems: nil)
        
        let parameters: [String: Any] = [
            "firstName": newPersonFirstName,
            "lastName": newPersonLastName,
            "age": newPersonAge
        ]
        
        let manager = NetworkManager.shared.manager
        return manager.rx.request(.post, urlComponents.url!, parameters: parameters, encoding: JSONEncoding.default, headers: ["x-api-key": Constants.apiKey])
            .flatMap {
                $0
                    .validate(statusCode: 200 ..< 300)
                    .validate(contentType: ["application/json"])
                    .rx.json()
        }
        .map { data in
            return JSON(data)
        }
    }
}
