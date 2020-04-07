
//  Created by Евгений Никитин on 01.12.2019.
//  Copyright © 2019 Evel-Devel. All rights reserved.

import UIKit

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var likes: CustomLikeButton!
    @IBAction func likeButton(_ sender: Any) { (sender as! CustomLikeButton).like() }
}
