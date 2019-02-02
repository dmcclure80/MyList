//
//  Item.swift
//  MyList
//
//  Created by Don  on 2/1/19.
//  Copyright © 2019 Don . All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    
    @objc dynamic var title : String = ""
    @objc dynamic var done: Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "item")
}
