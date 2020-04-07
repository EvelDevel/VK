 
//  Created by Евгений Никитин on 02.12.2019.
//  Copyright © 2019 Evel-Devel. All rights reserved.

import UIKit

class SearchGroupTableVC: UITableViewController {

    @IBOutlet weak var globalGroupSearch: UISearchBar!
    var presenter: SearchGroupPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SearchGroupPresenterImplementation()
        presenter?.viewDidLoad(tableView: tableView)
        globalGroupSearch.delegate = self
        updateNavigationBar()
    }

    // Кастомизируем Navigation Bar
    func updateNavigationBar() {
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = ""
        backButtonItem.tintColor = .white
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButtonItem
    }
    
    
    // MARK: Конфигурация и настройка таблицы
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection(section: section) ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return presenter?.cellForRowAt(indexPath: indexPath, tableView: tableView) ?? UITableViewCell()
    }
}

 
// MARK: Расширение для подключения Search Bar
extension SearchGroupTableVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.textDidChange(searchText: searchText, tableView: tableView)
    }
    /// Скрываем клавиатуру после нажатия "search"
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}
