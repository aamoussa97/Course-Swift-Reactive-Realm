import Foundation
import RealmSwift
import SwiftyJSON

class Person: Object {
    override static func primaryKey() -> String? {
        return "id"
    }
    
    @objc dynamic var id: String = ""
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var age: Int = 0
    var birthYear = RealmOptional<Int>() // Exercise: 2b
    
    let animals = List<Animal>()
    let cars = List<Car>()
    
    class func load(realm: Realm, id: String) -> Person? {
        return realm.objects(Person.self).first(where: { $0.id == id })
    }
    
    class func parseAndPersist(json: JSON, realm: Realm) -> Person {
        let dic = json.dictionaryObject! // TODO: handle optional?
        return realm.create(Person.self, value: dic, update: .all)
    }
}
