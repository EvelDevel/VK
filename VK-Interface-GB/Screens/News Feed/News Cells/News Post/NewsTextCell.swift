
//  Created by Евгений Никитин on 04.03.2020.
//  Copyright © 2020 Evel-Devel. All rights reserved.


import UIKit

class NewsTextCell: UITableViewCell {
    
    @IBOutlet weak var postText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
