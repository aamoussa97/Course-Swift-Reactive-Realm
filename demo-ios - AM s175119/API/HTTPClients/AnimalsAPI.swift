import Alamofire
import RealmSwift
import RxAlamofire
import RxSwift
import SwiftyJSON

class AnimalsAPI {
    
    // Add animal to server - Exercise: 3c
    class func postAnimal(newAnimalNameToAdd: String) -> Observable<JSON> {
        let urlComponents = NetworkManager.getApiComponents(path: "/animals", queryItems: nil)
        
        let parameters: [String: Any] = [
            "name": newAnimalNameToAdd
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
    
    // Add relationship between person and animal - Exercise: 3d
    class func addPersonAnimalRelationship(personIDToPut: String, animalIDToAddRelationship: String) -> Observable<JSON> {
        let urlComponents = NetworkManager.getApiComponents(path: "/persons/\(personIDToPut)/animals", queryItems: nil)
        
        let parameters: [String: Any] = [
            "animalId": animalIDToAddRelationship
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
    
    // Fetch animals from server and save to local realm database - Exercise: 4a
    class func fetchAnimalsFromServer() -> Observable<JSON> {
        let urlComponents = NetworkManager.getApiComponents(path: "/animals", queryItems: nil)
        
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
        
}
