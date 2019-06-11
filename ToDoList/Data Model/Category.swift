//
//  Category.swift
//  ToDoList
//
//  Created by Silvije Rajda on 6/10/19.
//  Copyright © 2019 Silvije Rajda. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
    
}
