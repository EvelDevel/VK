
//  Created by Евгений Никитин on 08.12.2019.
//  Copyright © 2019 Evel-Devel. All rights reserved.

import UIKit

class CustomCommentButton: UIButton {
    
    // Количество лайков и статус
    @IBInspectable var commented: Bool = false
    @IBInspectable var commentsCounter: Int = 0 { didSet { setupDefault() } }
    
    // Оцениваем текущее состояние
    func comment() {
        commented = !commented
        
        if commented {
            setCommented()
        } else {
            disableCommented()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDefault()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupDefault()
    }
    
    // Устанавливаем дефолтное состояние для кнопки
    private func setupDefault() {
        setTitle(String(describing: commentsCounter), for: .normal)
        
        if commented == true {
            setImage(UIImage(systemName: "text.bubble.fill"), for: .normal)
            tintColor = .red
        } else {
            setImage(UIImage(systemName: "text.bubble"), for: .normal)
            tintColor = .lightGray
        }
        
        imageEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 0, right: 0)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 2, right: 0)
    }
    
    // Ставим лайк
    private func setCommented() {
        commentsCounter += 1
        setImage(UIImage(systemName: "text.bubble.fill"), for: .normal)
        setTitle(String(describing: commentsCounter), for: .normal)
        tintColor = .darkGray
        animatedCommentsButton()
    }
    
    // Убираем лайк
    private func disableCommented() {
        commentsCounter -= 1
        setImage(UIImage(systemName: "text.bubble"), for: .normal)
        setTitle(String(describing: commentsCounter), for: .normal)
        tintColor = .lightGray
        animatedCommentsButton()
    }
    
    // Прописываем анимацию для нажатия
    private func animatedCommentsButton() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 1.1
        animation.toValue = 1
        animation.stiffness = 300
        animation.mass = 1
        animation.duration = 1
        animation.fillMode = CAMediaTimingFillMode.both
        layer.add(animation, forKey: nil)
    }
}
