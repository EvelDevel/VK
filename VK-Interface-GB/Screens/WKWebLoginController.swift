
//  Created by Евгений Никитин on 15.01.2020.
//  Copyright © 2020 Evel-Devel. All rights reserved.

import UIKit
import Alamofire
import WebKit

class WKWebLoginController: UIViewController {
    
    var webView: WKWebView!
    var vkAPI = VKApi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Создаем web-конфигурации
        let webViewConfig = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webViewConfig)
        webView.navigationDelegate = self
        
        // Создаем URL-компонент для нашей сессии
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [URLQueryItem(name: "client_id", value: "7367745"),
                                    URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
                                    URLQueryItem(name: "display", value: "mobile"),
                                    URLQueryItem(name: "scope", value: "336918"),
                                    URLQueryItem(name: "response_type", value: "token"),
                                    URLQueryItem(name: "v", value: "5.103") ]
        
        // Создаем реквест и "показываем" страницу
        let request = URLRequest(url: urlComponents.url!)
        view = webView
        webView.load(request)
    }
}


// MARK: navigationDelegate extension
extension WKWebLoginController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        // Разрешим переход если мы не получили токен
        guard let url = navigationResponse.response.url,
            url.path == "/blank.html",
            let fragment = url.fragment else {
                decisionHandler(.allow)
                return
        }
        // Обрабатываем текущий token
        /// Входящие параметры делим по знаку &, потом по =, после чего создаем словарь
        let parameters = fragment.components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) {
                value, parameters in
                var dict = value
                let key = parameters[0]
                let value = parameters[1]
                dict[key] = value
                return dict
        }
        // Сохраняем token в наш singleton-class
        UserSession.defaultSession.token = parameters["access_token"]!
        UserSession.defaultSession.id = parameters["user_id"]!
        decisionHandler(.cancel)
        
        // Переход с нашим токеном на следующий экран
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: "MainTab")
        self.present(nextViewController, animated: true, completion: nil)
    }
}
