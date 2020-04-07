
//  Created by Евгений Никитин on 29.01.2020.
//  Copyright © 2020 Evel-Devel. All rights reserved.

import UIKit

protocol FriendsConfigurator {
    func configure(view: FriendsTableVC)
}

class FriendsConfiguratorImplementation: FriendsConfigurator {
    func configure(view: FriendsTableVC) {
        view.presenter = FriendsPresenterImplementation(database: FriendsRepository(), view: view)
    }
}
