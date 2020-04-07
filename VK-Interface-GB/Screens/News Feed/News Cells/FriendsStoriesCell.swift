
//  Created by Евгений Никитин on 27.12.2019.
//  Copyright © 2019 Evel-Devel. All rights reserved.

import UIKit

enum CellType {
    case addStories(item: AddStroiesModel)
    case usersStories(item: StoriesModel)
}

class FriendsStoriesCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var bottomGrayLineHeight: NSLayoutConstraint!
    @IBOutlet weak var topGrayLineHeight: NSLayoutConstraint!
    @IBOutlet weak var storiesCollectionView: UICollectionView!
    
    var addStories: [CellType] = []
    var usersStories: [CellType] = []
    var allStrories: [[CellType]] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialization()
        makeThinGrayLine()
        addContent()
    }
    
    // Кастомизация серых линий (separators)
    func makeThinGrayLine() {
        topGrayLineHeight.constant = 1.0 / UIScreen.main.scale
        bottomGrayLineHeight.constant = 1.0 / UIScreen.main.scale
    }
    
    // Заполняем массивы информацией из "базы данных"
    func addContent() {
        addStories.append(contentsOf: StoriesDatabase.getAuthor().map { CellType.addStories(item: $0) })
        usersStories.append(contentsOf: StoriesDatabase.getStories().map { CellType.usersStories(item: $0) })
        allStrories.append(addStories)
        allStrories.append(usersStories)
    }
    
    
    // MARK: Регистрируем прототипы и указываем количество секция и ячеек
    // Инициализируем и регистрируем прототип нашей CollectionVewCell
    func initialization() {
        self.storiesCollectionView.dataSource = self
        self.storiesCollectionView.delegate = self
        self.storiesCollectionView.register(UINib.init(nibName: "UserStoriesCell", bundle: nil),
                                            forCellWithReuseIdentifier: "UserStoriesCell")
        self.storiesCollectionView.register(UINib.init(nibName: "AddStoriesCell", bundle: nil),
                                            forCellWithReuseIdentifier: "AddStoriesCell")
    }
    // Количество секций
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return allStrories.count
    }
    // Количество ячеек
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allStrories[section].count
    }
    
    
    // MARK: Кастомизация ячеек
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = allStrories[indexPath.section][indexPath.row]
        
        switch cell {
            
        // Первая ячейка "добавить историю"
        case let .addStories(item: addButton):
            guard let add = collectionView.dequeueReusableCell(withReuseIdentifier: "AddStoriesCell", for: indexPath) as? AddStoriesCell else {
                return UICollectionViewCell()
            }
            
            add.avatar.image = UIImage(named: addButton.avatarPath)
            add.name.text = addButton.username
            return add
            
        // Вторая ячейка (Истории)
        case let .usersStories(item: usersStories):
            guard let story = collectionView.dequeueReusableCell(withReuseIdentifier: "UserStoriesCell", for: indexPath) as? UserStoriesCell else {
                return UICollectionViewCell()
            }
            
            // Аватарка и имя пользователя
            story.avatar.image = UIImage(named: usersStories.avatarPath)
            story.username.text = usersStories.username
            
            // Стиль текста надписей и голубой круг
            if usersStories.watchStatus == false {
                story.username.textColor = .gray
                story.blueRadius.backgroundColor = .clear
            } else {
                story.username.textColor = usersStories.usernameColor
                story.blueRadius.backgroundColor = #colorLiteral(red: 0.2880442441, green: 0.5009066463, blue: 0.7458965778, alpha: 1)
            }
            return story
        }
    }
}
