
//  Created by Евгений Никитин on 26.12.2019.
//  Copyright © 2019 Evel-Devel. All rights reserved.

import UIKit

class WhatIsNewCell: UITableViewCell {
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var whatIsNewField: UITextField!
    @IBOutlet weak var addPhoto: UIImageView!
    @IBOutlet weak var lifeStream: UIImageView!
    @IBOutlet weak var bottomGrayLineHeight: NSLayoutConstraint!
    @IBOutlet weak var topGrayLineHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        changePlaceholderText()
        topGrayLineHeight.constant = 1.0 / UIScreen.main.scale
        bottomGrayLineHeight.constant = 1.0 / UIScreen.main.scale
    }
    
    // Конфигурируем текст плейсхолдеров
    func changePlaceholderText() {
        whatIsNewField.attributedPlaceholder = NSAttributedString(string: "Что у Вас нового?", attributes: [
            .foregroundColor: UIColor.gray,
            .font: UIFont.systemFont(ofSize: 14.0, weight: .light)
        ])
    }
}
