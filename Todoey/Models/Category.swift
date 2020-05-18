//
//  Category.swift
//  Todoey
//
//  Created by Amir Daliri
//  Copyright © 2020 Amir Daliri. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object{
    @objc dynamic var name: String = ""
    @objc dynamic var colour : String = ""
    let items = List<Item>()
}
