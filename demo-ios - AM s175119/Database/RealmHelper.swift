import Foundation
import RealmSwift

class RealmHelper {

    class func setup() {
        var configuration = Realm.Configuration.defaultConfiguration
        configuration.fileURL = self.getFileURL()
        configuration.deleteRealmIfMigrationNeeded = true
        Realm.Configuration.defaultConfiguration = configuration

//        self.compactDB() // IDEA: Compact Realm
    }

    private class func getFileURL() -> URL? {
        let fileManager = FileManager.default
        do {
            let directory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)

            let realmDirectory = directory.appendingPathComponent("Realm")

            let databaseName = "db.realm"
            let realmPath = realmDirectory.appendingPathComponent(databaseName)

            if !fileManager.fileExists(atPath: realmDirectory.path) {
                try fileManager.createDirectory(at: realmDirectory, withIntermediateDirectories: false, attributes: nil)
            }
            if !fileManager.fileExists(atPath: realmPath.path) {
                fileManager.createFile(atPath: realmPath.path, contents: nil, attributes: nil)
            }

            debugPrint("Realm path: \(realmPath)")

            return realmPath
        }
        catch {
            debugPrint(error) // handle error
        }
        return nil
    }
}
