
//  Created by Евгений Никитин on 08.12.2019.
//  Copyright © 2019 Evel-Devel. All rights reserved.

import UIKit

class CustomRepostButton: UIButton {
    
    // Количество лайков и статус
    @IBInspectable var reposted: Bool = false
    @IBInspectable var repostCounter: Int = 0 { didSet { setupDefault() } }
    
    // Оцениваем текущее состояние
    func repost() {
        reposted = !reposted
        
        if reposted {
            setReposted()
        } else {
            disableReposted()
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
        setTitle(String(describing: repostCounter), for: .normal)
        
        if reposted == true {
            setImage(UIImage(systemName: "arrowshape.turn.up.right.fill"), for: .normal)
            tintColor = .red
        } else {
            setImage(UIImage(systemName: "arrowshape.turn.up.right"), for: .normal)
            tintColor = .lightGray
        }
        
        imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 2, bottom: 2, right: 0)
    }
    
    // Ставим лайк
    private func setReposted() {
        repostCounter += 1
        setImage(UIImage(systemName: "arrowshape.turn.up.right.fill"), for: .normal)
        setTitle(String(describing: repostCounter), for: .normal)
        tintColor = .darkGray
        animatedRepostButton()
    }
    
    // Убираем лайк
    private func disableReposted() {
        repostCounter -= 1
        setImage(UIImage(systemName: "arrowshape.turn.up.right"), for: .normal)
        setTitle(String(describing: repostCounter), for: .normal)
        tintColor = .lightGray
        animatedRepostButton()
    }
    
    // Прописываем анимацию для нажатия
    private func animatedRepostButton() {
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
