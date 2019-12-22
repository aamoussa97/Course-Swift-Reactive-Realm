import Foundation
import SwiftyJSON

class JsonService {
    
    static func loadJson(name: String) -> JSON {
        let path = Bundle.main.path(forResource: name, ofType: "json")!
        let jsonString = try! String(contentsOfFile: path, encoding: .utf8)
        return JSON(parseJSON: jsonString)
    }
}
