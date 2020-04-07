
//  Created by Евгений Никитин on 07.12.2019.
//  Copyright © 2019 Evel-Devel. All rights reserved.

import UIKit

class RoundImageNoAnimation: UIView {
    
    // MARK: - Закругление родительской вьюшки
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.cornerRadius = rect.height / 2
        clipsToBounds = true
    }
}
