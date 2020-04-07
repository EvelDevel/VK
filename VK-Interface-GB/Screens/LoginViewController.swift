
//  Created by Евгений Никитин on 23.11.2019.
//  Copyright © 2019 Evel-Devel. All rights reserved.

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var graySeparatorLine: UIView!
    @IBOutlet weak var loginButtonOutlet: UIButton!
    @IBAction func loginButton(_ sender: Any) {}
    @IBOutlet weak var heightOfGrayLine: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardOnTap()
        makeThinGrayLine()
        changePlaceholderText()
    }
    
    
    // MARK: Интерфейс
    // Конфигурируем текст плейсхолдеров
    func changePlaceholderText() {
        /// Текст логина
        loginInput.attributedPlaceholder = NSAttributedString(string: "Email или телефон", attributes: [
            .foregroundColor: UIColor.gray,
            .font: UIFont.systemFont(ofSize: 16.0, weight: .light)
        ])
        /// Текст пароля
        passwordInput.attributedPlaceholder = NSAttributedString(string: "Пароль", attributes: [
            .foregroundColor: UIColor.gray,
            .font: UIFont.systemFont(ofSize: 16.0, weight: .light)
        ])
    }
    // Задаем реальную высоту серой линии в один пиксель
    func makeThinGrayLine() {
        heightOfGrayLine.constant =  1.0 / UIScreen.main.scale
    }
    // Белый цвет текста у status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    // MARK: Скрыть клавиатуру
    func hideKeyboardOnTap() {
        let hideAction = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(hideAction)
    }
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    
    // MARK: Проверка введенных логина и пароля
    // Основная проверка, "должны ли мы запустить переход?"
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let checkResult = checkUserData()
        /// Делаем проверку только в случае перехода по локальной авторизации
        if identifier == "LocalSegue" {
            if !checkResult {
                showLoginError()
            }
            return checkResult
        }
        /// В противном случае - не смотрим на поля ввода и просто переходим на WK-Web
        return true
    }
    // Проверка полей
    func checkUserData() -> Bool {
        guard let login = loginInput.text, let password = passwordInput.text else { return false }
        /// Для удобства во время тестов, ничего вводить не нужно (иначе можно заколебаться)
        if login == "" && password == "" {
            return true
        } else {
            return false
        }
    }
    // Создаем окно ошибки
    func showLoginError() {
        /// Создаем контроллер
        let alter = UIAlertController(title: "Ошибка", message: "Введены некорректные данные пользователя. Повторите попытку.", preferredStyle: .alert)
        /// Создаем кнопку для UIAlertController
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        /// Добавляем кнопку на UIAlertController
        alter.addAction(action)
        /// Показываем UIAlertController
        present(alter, animated: true, completion: nil)
    }
    
    
    // MARK: Изменение высоты ScrollView при появлении и исчезновении клавиатуры
    // Клавиатура появляется
    @objc func keyboardWasShown(notification: Notification) {
        /// Получаем размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        /// Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    // Клавиатура исчезает
    @objc func keyboardWillBeHidden(notification: Notification) {
        /// Устанавливаем отступ внизу UIScrollView, равный 0
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
    }
    // Сообщения из центра уведомлений
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        /// Подписываемся на два уведомления: одно приходит при появлении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        /// Второе — когда она пропадает
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    // Отписка от уведомлений при исчезновении контроллера с экрана
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
