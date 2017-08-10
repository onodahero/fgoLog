//
//  quest.swift
//  fgoLog
//
//  Created by 斧田洋人 on 2017/08/08.
//  Copyright © 2017年 斧田洋人. All rights reserved.
//

import UIKit

class Quest {
    
    var area: String!
    var name: String!
    var stamina: Int!
    var drop: [Drop]!
    
    init(area: String, name: String, stamina: Int, drop: [Drop]){
        self.area = area
        self.name = name
        self.stamina = stamina
        self.drop = drop
    }
    
//    func getImage() -> UIImage{
//        return UIImage(named: imagename)!
//    }
}

class Drop {
    
    var name: String = ""
    var count: Int = 0
    
    init(name: String) {
        self.name = name
    }
}
