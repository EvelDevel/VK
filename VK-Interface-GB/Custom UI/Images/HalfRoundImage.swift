
//  Created by Евгений Никитин on 05.01.2020.
//  Copyright © 2020 Evel-Devel. All rights reserved.

import UIKit

class HalfRoundImage: UIView {
    
    // MARK: Закругление родительской вьюшки
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.cornerRadius = 15
        clipsToBounds = true
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    // MARK: Анимация
    // Распознаем нажатие, чтобы анимировать аватарку
    lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(onTap))
        // Количество нажатий, необходимое для распознавания
        recognizer.numberOfTapsRequired = 1
        // Количество пальцев, которые должны коснуться экрана для распознавания
        recognizer.numberOfTouchesRequired = 1
        return recognizer
    }()
    
    @objc func onTap() {
        roundImageCustomAnimation()
    }
    
    // Конфигурируем
    func roundImageCustomAnimation() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.9
        animation.toValue = 1
        animation.stiffness = 400
        animation.mass = 1
        animation.duration = 0.5
        animation.beginTime = CACurrentMediaTime()
        animation.fillMode = CAMediaTimingFillMode.backwards
        layer.add(animation, forKey: nil)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addGestureRecognizer(tapGestureRecognizer)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
