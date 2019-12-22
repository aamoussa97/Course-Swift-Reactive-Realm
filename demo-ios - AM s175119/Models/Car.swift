//
//  Car.swift
//  demo-ios
//
//  Created by Ali Moussa on 31/10/2019.
//  Copyright © 2019 OverallApps IVS. All rights reserved.
//

import Foundation
import RealmSwift

// Exercise: 2c
class Car: Object {
    override static func primaryKey() -> String? {
        return "id"
    }
    
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var horsePower: Int = 0
}
