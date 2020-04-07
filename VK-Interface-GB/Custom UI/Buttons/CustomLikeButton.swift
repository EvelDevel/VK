
//  Created by Евгений Никитин on 08.12.2019.
//  Copyright © 2019 Evel-Devel. All rights reserved.

import UIKit

class CustomLikeButton: UIButton {
    
    // Количество лайков и статус
    @IBInspectable var liked: Bool = false
    @IBInspectable var likeCount: Int = 0 { didSet { setupDefault() } }
    
    // Оцениваем текущее состояние 
    func like() {
        liked = !liked
        
        if liked {
            setLike()
        } else {
            disableLike()
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
        setTitle(String(describing: likeCount), for: .normal)
        
        if liked == true {
            setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
            tintColor = .red
        } else {
            setImage(UIImage(systemName: "suit.heart"), for: .normal)
            tintColor = .lightGray
        }
        
        imageEdgeInsets = UIEdgeInsets(top: 2, left: 0, bottom: 3, right: 0)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 2, bottom: 2, right: 0)
    }
    
    // Ставим лайк
    private func setLike() {
        likeCount += 1
        setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
        setTitle(String(describing: likeCount), for: .normal)
        tintColor = .red
        animatedLikeButton()
    }
    
    // Убираем лайк
    private func disableLike() {
        likeCount -= 1
        setImage(UIImage(systemName: "suit.heart"), for: .normal)
        setTitle(String(describing: likeCount), for: .normal)
        tintColor = .lightGray
        animatedLikeButton()
    }
    
    // Прописываем анимацию для нажатия
    private func animatedLikeButton() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 1.1
        animation.toValue = 1
        animation.stiffness = 500
        animation.mass = 1
        animation.duration = 1
        animation.fillMode = CAMediaTimingFillMode.both
        layer.add(animation, forKey: nil)
    }
}
