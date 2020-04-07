
//  Created by Евгений Никитин on 01.12.2019.
//  Copyright © 2019 Evel-Devel. All rights reserved.

import UIKit

class FriendCell: UITableViewCell {
    
    @IBOutlet weak var avatarContainer: RoundImage!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var chevrone: UIImageView! 
    
    // Свойства для расчета фреймов
    private let avatarViewHeight: CGFloat = 40
    private let usernameViewHeight: CGFloat = 20
    private let chevronViewHeight: CGFloat = 20
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutAvatarContainer()
        layoutUsername()
        layoutChevrone()
    }
    
    // MARK: Ручной расчет фреймов (альтернатива констрейнтам)
    
    /// Положение и размер аватарки
    private func layoutAvatarContainer() {
        avatarContainer.frame = CGRect(x: 10,
                                       y: contentView.bounds.midY - avatarViewHeight/2,
                                       width: avatarViewHeight,
                                       height: avatarViewHeight)
    }
    /// Положение и размер имени
    private func layoutUsername() {
        let origin = CGPoint(x: 60, y: contentView.bounds.midY - usernameViewHeight/2)
        username.frame = CGRect(origin: origin, size: username.intrinsicContentSize)
    }
    /// Положение и размер иконки справа (шеврон)
    private func layoutChevrone() {
        chevrone.frame = CGRect(x: contentView.bounds.maxX - 15,
                                y: contentView.bounds.midY - chevronViewHeight/2,
                                width: 8,
                                height: chevronViewHeight)
    }
    
    /// Если переиспользование начнет обрезать имя пользователя внутри username
    /// override func prepareForReuse() {
    /// super.prepareForReuse()
    /// self.setNeedsLayout()
    /// }
}
