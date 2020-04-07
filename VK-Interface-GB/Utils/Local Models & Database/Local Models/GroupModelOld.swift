
//  Created by Евгений Никитин on 02.12.2019.
//  Copyright © 2019 Evel-Devel. All rights reserved.

import UIKit

class GroupModelOld {
    var groupName:  String
    var avatarPath: String
    var id:         Int
    var kind:       String
    
    init(groupName: String, avatarPath: String, id: Int, kind: String) {
        self.groupName =    groupName
        self.avatarPath =   avatarPath
        self.id =           id
        self.kind =         kind
    }
}
