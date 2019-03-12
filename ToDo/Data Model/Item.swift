//
//  Item.swift
//  ToDo
//
//  Created by Md Zahidul Islam Mazumder on 11/3/19.
//  Copyright © 2019 Md Zahidul islam. All rights reserved.
//

import Foundation

class Item:Encodable,Decodable {
    var name: String = ""
    var check:Bool = false
    
}
