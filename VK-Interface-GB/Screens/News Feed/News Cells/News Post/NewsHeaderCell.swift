
//  Created by Евгений Никитин on 04.03.2020.
//  Copyright © 2020 Evel-Devel. All rights reserved.


import UIKit

class NewsHeaderCell: UITableViewCell {
    
    @IBOutlet weak var username: UILabel! { didSet { username.backgroundColor = .white } }
    @IBOutlet weak var time: UILabel! { didSet { time.backgroundColor = .white } }
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var topGrayLine: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        topGrayLine.constant =  1.0 / UIScreen.main.scale
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
