//
//  Userdata.swift
//  Hakadorikun
//
//  Created by 奥若菜 on 2021/06/02.
//

import Foundation
import UIKit
import RealmSwift

//class KadaiObj: Object{
//    @objc dynamic var title: String? = nil
//}

class  EventObj: Object {
    
    @objc dynamic var title = ""
    @objc dynamic var place = ""
    @objc dynamic var address = ""
    @objc dynamic var url = ""
    @objc dynamic var memo = ""
    @objc dynamic var start_time: Date? = nil
    @objc dynamic var end_time: Date? = nil
    @objc dynamic var all_day = 0
    @objc dynamic var ID = ""
    
    //Primary Keyの設定
    override static func primaryKey() -> String? {
        return "ID"
    }
    
}
