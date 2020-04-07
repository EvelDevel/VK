
//  Created by Евгений Никитин on 04.03.2020.
//  Copyright © 2020 Evel-Devel. All rights reserved.


import UIKit

class NewsFooterCell: UITableViewCell {
    
    @IBAction func likeButton(_ sender: Any) { (sender as! CustomLikeButton).like() }
    @IBAction func comments(_ sender: Any) { (sender as! CustomCommentButton).comment() }
    @IBAction func repost(_ sender: Any) { (sender as! CustomRepostButton).repost() }
    @IBOutlet weak var bottomGrayLine: NSLayoutConstraint!
    @IBOutlet weak var likes: CustomLikeButton!
    @IBOutlet weak var comments: CustomCommentButton! 
    @IBOutlet weak var repost: CustomRepostButton!
    @IBOutlet weak var viewsCounter: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        bottomGrayLine.constant = 1.0 / UIScreen.main.scale
    }
}
