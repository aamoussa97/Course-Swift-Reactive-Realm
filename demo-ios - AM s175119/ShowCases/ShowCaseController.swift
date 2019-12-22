import Foundation
import UIKit
import RealmSwift
import RxSwift
import SwiftyJSON

class ShowCaseController {
    static var realm = Realm.create()
    static var person = Person()
    
    static func run() {
        readPerson() // Read person from Realm DB
        
        // Exercise2aAddPerson() // Add person - Exercise: 2a
        // Exercise2bAddOptionalProperty() // Add optional property to person - Exercise: 2b
        // Exercise2cAddCarsToPerson() // Add cars to person object - Exercise: 2c
        // Exercise3aPutPersonsToAPI() // PUT to PersonsAPI - Exercise: 3a
        // Exercise3bPostPersonsToAPI() // POST to PersonsAPI - Exercise: 3b
        // Exercise3cAddAnimalToAnimalsAPI() // Add animal to server - Exercise: 3c
        // Exercise3dAddRelationshipBetweenPersonAndAnimal() // Add relationship between person and animal - Exercise: 3d
        // Exercise3eFetchPersonsFromAPIWithErrorMessage401() // Fetch persons from server, with error code message alert, Error 401 - Exercise: 3e-401 - Click on button to trigger this error.
        // Exercise3eFetchPersonsFromAPIWithErrorMessage404() // Fetch persons from server, with error code message alert, Error 404 - Exercise: 3e-404 - Click on button to trigger this error.
        // Exercise4aFetchAnimalsFromAPIToLocalRealmDB() // Fetch animals from server and save to local realm database - Exercise: 4a
        // FetchAnimalsFromAPIToLocalRealmDB // Own extra 1
    }
    
    // Read person from Realm DB
    class func readPerson() {
        //let person = Person()
        person.id = "3"
        
        if let readPersonFromRealm = Person.load(realm: realm, id: person.id) {
            debugPrint() // Print empty line
            debugPrint("Read person from realm DB:")
            debugPrint("\(readPersonFromRealm.firstName) \(readPersonFromRealm.lastName), \(readPersonFromRealm.age), \(readPersonFromRealm.birthYear.value ?? 1970)")
            
            debugPrint() // Print empty line
            debugPrint("Cars owned by \(readPersonFromRealm.firstName):")
            readPersonFromRealm.cars.forEach { (Car) in
                debugPrint("Model: \(Car.name), Horsepower: \(Car.horsePower)")
            }
        } else {
            debugPrint("Person with \(person.id) not found.")
        }
    }
    
    // Add person - Exercise: 2a
    class func Exercise2aAddPerson() {
        person.id = "3"
        person.firstName = "Ali"
        person.lastName = "Moussa"
        person.age = 22
    }
    
    // Add optional property to person - Exercise: 2b
    class func Exercise2bAddOptionalProperty() {
        person.birthYear = RealmOptional<Int>(1997)
    }
    
    // Add cars to person object - Exercise: 2c
    class func Exercise2cAddCarsToPerson() {
        let carTeslaModelX = Car()
        carTeslaModelX.id = "1"
        carTeslaModelX.name = "Tesla Model X"
        carTeslaModelX.horsePower = 250
        
        let carTeslaModel3 = Car()
        carTeslaModel3.id = "2"
        carTeslaModel3.name = "Tesla Model 3"
        carTeslaModel3.horsePower = 170
        
        person.cars.append(carTeslaModelX)
        person.cars.append(carTeslaModel3)
    }
    
    // Create person
    class func createPerson() {
        realm.safeWrite {
            _ = realm.create(Person.self, value: person, update: .all) //debugPrint(managedUser)
        }
    }
    
    // PUT to PersonsAPI - Exercise: 3a
    class func Exercise3aPutPersonsToAPI() {
        let changeNewPersonIDToPut = "eg0YDAQ38CMemz8fa0U"
        let changeNewPersonFirstName = "Stan"
        let changeNewPersonLastName = "Lee"
        let changeNewPersonAge = 31
        
        let putPersonsAPI = PersonsAPI.put(personIDToPut: changeNewPersonIDToPut, changeNewPersonFirstName: changeNewPersonFirstName, changeNewPersonLastName: changeNewPersonLastName, changeNewPersonAge: changeNewPersonAge)
            .subscribeOn(ConcurrentDispatchQueueScheduler.background)
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { (json) in
                
                debugPrint(json)
                
            })
    }
    
    // POST to PersonsAPI - Exercise: 3b
    class func Exercise3bPostPersonsToAPI() {
        let newPersonFirstName = "Craig"
        let newPersonLastName = "Federighi"
        let newPersonAge = 50
        
        let postPersonsAPI = PersonsAPI.post(newPersonFirstName: newPersonFirstName, newPersonLastName: newPersonLastName, newPersonAge: newPersonAge)
            .subscribeOn(ConcurrentDispatchQueueScheduler.background)
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { (json) in
                
                debugPrint(json)
                
            })
    }
    
    // Add animal to server - Exercise: 3c
    class func Exercise3cAddAnimalToAnimalsAPI() {
        let newAnimalToPost = "Woody"
        let postAnimalsAPI = AnimalsAPI.postAnimal(newAnimalNameToAdd: newAnimalToPost)
            .subscribeOn(ConcurrentDispatchQueueScheduler.background)
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { (json) in
                
                debugPrint(json)
                
            })
    }
    
    // Add relationship between person and animal - Exercise: 3d
    class func Exercise3dAddRelationshipBetweenPersonAndAnimal() {
        
        let personIDToPut = "jqxijCSfoDmfRlHCYv0"
        let animalIDToAddRelationship = "zwzYaYtE28YYPHY_VN8"
        
        let relationshipPersonAnimal = AnimalsAPI.addPersonAnimalRelationship(personIDToPut: personIDToPut, animalIDToAddRelationship: animalIDToAddRelationship)
            .subscribeOn(ConcurrentDispatchQueueScheduler.background)
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { (json) in
                
                debugPrint(json)
                
            })
    }
    
    // Fetch persons from server, with error code message alert, Error 401 - Exercise: 3e-401
    class func Exercise3eFetchPersonsFromAPIWithErrorMessage401() -> Observable<JSON> {
        return PersonsAPI.fetchPersonsFromServerWithErrorCode401()
            .subscribeOn(ConcurrentDispatchQueueScheduler.background)
            .observeOn(MainScheduler.asyncInstance)
    }
    
    // Fetch persons from server, with error code message alert, Error 404 - Exercise: 3e-404
    class func Exercise3eFetchPersonsFromAPIWithErrorMessage404() -> Observable<JSON> {
        return PersonsAPI.fetchPersonsFromServerWithErrorCode404()
            .subscribeOn(ConcurrentDispatchQueueScheduler.background)
            .observeOn(MainScheduler.asyncInstance)
    }
    
    // Fetch animals from server and save to local realm database - Exercise: 4a
    class func Exercise4aFetchAnimalsFromAPIToLocalRealmDB() {
        let fetchAnimalsFromServerAPI = AnimalsAPI.fetchAnimalsFromServer()
            .subscribeOn(ConcurrentDispatchQueueScheduler.background)
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { (json) in
                
                // debugPrint(json)
                
                let animalsJSON = json["animals"]
                
                realm.safeWrite {
                    let animals = animalsJSON.arrayValue.map({ Animal.parseAndPersist(json: $0, realm: realm) })
                    
                    animals.forEach { (Animal) in
                        debugPrint(Animal.name)
                    }
                }
                
            })
    }
    
    // Fetch persons from server and save to local realm database - Own extra 1
    class func FetchAnimalsFromAPIToLocalRealmDB() {
        let fetchPersonsFromServerAPI = PersonsAPI.fetchPersonsFromServer()
            .subscribeOn(ConcurrentDispatchQueueScheduler.background)
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { (json) in
                
                // debugPrint(json)
                
                let personsJSON = json["persons"]
                
                realm.safeWrite {
                    let persons = personsJSON.arrayValue.map({ Person.parseAndPersist(json: $0, realm: realm) })
                    
                    persons.forEach { (Person) in
                        debugPrint(Person.firstName)
                    }
                }
                
            })
    }
    
    // Fetch data
    class func fetchAuthorName() -> String {
        let assignmentAuthorAndName = "Ali s175119 | Realm and Reactive Programming"
        return assignmentAuthorAndName
    }
    
}
