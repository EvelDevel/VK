
//  Created by Евгений Никитин on 02.12.2019.
//  Copyright © 2019 Evel-Devel. All rights reserved.

import UIKit

protocol PhotosConfigurator {
    func configure(view: PhotosCollectionVC, userID: String)
}

class PhotosConfiguratorImplementation: PhotosConfigurator {
    func configure(view: PhotosCollectionVC, userID: String) {
        view.presenter = PhotosPresenterImplementation(database: PhotosRepository(), view: view, userID: userID)
    }
}
