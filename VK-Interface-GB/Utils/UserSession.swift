
//  Created by Евгений Никитин on 10.01.2020.
//  Copyright © 2020 Evel-Devel. All rights reserved.

import UIKit

class UserSession {
    static let defaultSession = UserSession()
    private init() { }
    
    var token = ""
    var id = "" 
}
