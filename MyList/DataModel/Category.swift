//
//  Category.swift
//  MyList
//
//  Created by Don  on 2/1/19.
//  Copyright © 2019 Don . All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name : String = ""
    let item = List<Item>()
}

