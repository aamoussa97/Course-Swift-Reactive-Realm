import RealmSwift

extension Realm {

    class func create() -> Realm {
        do {
            return try Realm()
        } catch {
            debugPrint(error)
            // TODO: Delete corrupted Realm?
        }
        fatalError("Realm: Create failed!")
    }

    func safeWrite(_ block: (() throws -> Void)) {
        do {
            if self.isInWriteTransaction {
                try block()
            } else {
                try write(block)
            }
        } catch {
            debugPrint(error)
        }
        
        // TODO: Handle?
    }
}
