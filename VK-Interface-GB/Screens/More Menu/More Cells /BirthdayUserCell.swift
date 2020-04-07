
//  Created by Евгений Никитин on 05.01.2020.
//  Copyright © 2020 Evel-Devel. All rights reserved.

import UIKit

class BirthdayUserCell: UITableViewCell {
    
    @IBOutlet weak var avatar: UIImageView! 
    @IBOutlet weak var username: UILabel! 
    @IBOutlet weak var when: UILabel! 
    @IBOutlet weak var sendGift: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
