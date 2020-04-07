
//  Created by Евгений Никитин on 02.12.2019.
//  Copyright © 2019 Evel-Devel. All rights reserved.

import UIKit

protocol GroupsConfigurator {
    func configure(view: GroupsTableVC)
}

class GroupsConfiguratorImplementation: GroupsConfigurator {
    func configure(view: GroupsTableVC) {
        view.presenter = GroupsPresenterImplementation(database: GroupsRepository(), view: view)
    }
}
