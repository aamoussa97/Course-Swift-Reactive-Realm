import Foundation
import RealmSwift
import SwiftyJSON

class Animal: Object {
    override static func primaryKey() -> String? {
        return "id"
    }
    
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    
    class func parseAndPersist(json: JSON, realm: Realm) -> Animal {
        let dic = json.dictionaryObject! // TODO: handle optional?
        return realm.create(Animal.self, value: dic, update: .all)
    }
}
