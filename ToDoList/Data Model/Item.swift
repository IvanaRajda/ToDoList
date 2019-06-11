//
//  Item.swift
//  ToDoList
//
//  Created by Silvije Rajda on 6/10/19.
//  Copyright © 2019 Silvije Rajda. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object{
  @objc dynamic var title : String = ""
  @objc dynamic var done : Bool = false
 @objc dynamic var dateCreated : Date?
  var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
