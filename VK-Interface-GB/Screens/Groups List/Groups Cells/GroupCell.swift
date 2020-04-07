
//  Created by Евгений Никитин on 02.12.2019.
//  Copyright © 2019 Evel-Devel. All rights reserved.

import UIKit

class GroupCell: UITableViewCell {
    
    @IBOutlet weak var avatarContainer: RoundImage!
    @IBOutlet weak var groupname: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var groupKind: UILabel!
    
    // Свойства для расчета фреймов
    private let avatarViewHeight: CGFloat = 40
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutAvatarContainer()
        layoutGroupname()
        layoutGroupkind()
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
    private func layoutGroupname() {
        let origin = CGPoint(x: 60, y: contentView.bounds.midY - 15)
        groupname.frame = CGRect(origin: origin, size: groupname.intrinsicContentSize)
    }
    /// Положение и размер иконки справа (шеврон)
    private func layoutGroupkind() {
        let origin = CGPoint(x: 60, y: contentView.bounds.midY + 4)
        groupKind.frame = CGRect(origin: origin, size: groupKind.intrinsicContentSize)
    }
    
    /// Если переиспользование начнет обрезать имя группы внутри groupname
    /// override func prepareForReuse() {
    /// super.prepareForReuse()
    /// self.setNeedsLayout()
    /// }
}
