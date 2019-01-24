//
//  Item.swift
//  MyList
//
//  Created by Don  on 1/22/19.
//  Copyright © 2019 Don . All rights reserved.
//

import Foundation

class Item: Encodable, Decodable {
    var title : String = ""
    var done : Bool = false
}
