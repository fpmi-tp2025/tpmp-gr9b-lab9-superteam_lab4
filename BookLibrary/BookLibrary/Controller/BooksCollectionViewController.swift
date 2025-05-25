import UIKit

/// Контроллер для отображения коллекции книг
class BooksCollectionViewController: UIViewController {
    // MARK: - Свойства
    var collectionView: UICollectionView! // Убран private для доступа в тестах
    var books: [Book] = [] // Убран private для доступа в тестах
    
    // MARK: - Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar() // Настройка навигационной панели
        setupCollectionView() // Настройка коллекции
        loadBooks() // Загрузка данных
    }
    
    // MARK: - Настройка навигационной панели
    private func setupNavigationBar() {
        title = NSLocalizedString("books_title", comment: "")
        navigationItem.backButtonTitle = NSLocalizedString("back_button", comment: "")
    }
    
    // MARK: - Настройка коллекции
    private func setupCollectionView() {
        // Настройка layout для коллекции
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 160, height: 200)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        // Инициализация коллекции
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.register(BookCell.self, forCellWithReuseIdentifier: "BookCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.accessibilityIdentifier = "books_collection_view" // Добавляем идентификатор
        view.addSubview(collectionView)
    }
    
    // MARK: - Загрузка данных
    // Добавлен параметр bundle для тестирования
    func loadBooks(from bundle: Bundle = Bundle.main, language: String? = nil) {
        let fileName: String
        if let language = language {
            switch language {
            case "ru": fileName = "Books_ru"
            case "be": fileName = "Books_be"
            default: fileName = "Books_en"
            }
        } else {
            fileName = "Books_en" // По умолчанию английский
        }
        
        guard let path = bundle.path(forResource: fileName, ofType: "plist"),
              let booksData = NSArray(contentsOfFile: path) as? [[String: String]] else {
            print("Ошибка загрузки данных")
            books = [] // Очищаем массив книг
            collectionView.reloadData()
            return
        }
        
        books = booksData.map { dict in
            Book(
                title: dict["title"] ?? "",
                author: dict["author"] ?? "",
                description: dict["description"] ?? "",
                imageName: dict["imageName"] ?? ""
            )
        }
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension BooksCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCell", for: indexPath) as! BookCell
        cell.configure(with: books[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension BooksCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.book = books[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
