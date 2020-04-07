
//  Created by Евгений Никитин on 16.03.2020.
//  Copyright © 2020 Evel-Devel. All rights reserved.

import Foundation

enum ApplicationErrors: Error {
    
    /// Проблеми при сетевых запросах
    case parsingFailed
    case badRequest
    
    /// Проблемы в презентерах 
    case getFriendsFromApiError
    case getPhotosFromApiError
    case getGroupsFromApiError
    case searchGroupsError
    case getNewsfeedError
}
