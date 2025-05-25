import XCTest
@testable import BookLibrary

/// Класс для тестирования отображения данных в коллекции книг
class BooksCollectionViewControllerDataTests: XCTestCase {
    
    var booksVC: BooksCollectionViewController!
    
    override func setUp() {
        super.setUp()
        // Инициализируем контроллер коллекции книг
        booksVC = BooksCollectionViewController()
        booksVC.loadViewIfNeeded() // Для инициализации UI-элементов
    }
    
    /// Тест на проверку корректности отображения данных в коллекции
    func testBooksDisplayedCorrectly() {
        // Подменяем язык через MockBundle
        let mockBundle = TestMockBundle(language: "en") // Переименовано для избежания конфликта
        
        // Загружаем данные через MockBundle
        booksVC.loadBooks(from: mockBundle, language: "en")
        
        // Проверяем количество ячеек в коллекции
        guard let collectionView = booksVC.collectionView else {
            XCTFail("Коллекция не должна быть nil")
            return
        }
        
        XCTAssertEqual(collectionView.numberOfItems(inSection: 0), 3, "Количество книг в коллекции должно быть 3")
        
        // Проверяем данные первой книги через dataSource
        let indexPath = IndexPath(item: 0, section: 0)
        guard let cell = booksVC.collectionView(collectionView, cellForItemAt: indexPath) as? BookCell else {
            XCTFail("Не удалось получить ячейку для проверки")
            return
        }
        
        // Проверяем текст заголовка
        XCTAssertEqual(cell.titleLabel.text, "War and Peace", "Название первой книги отображается неверно")
        
        // Проверяем изображение
        XCTAssertNotNil(cell.imageView.image, "Изображение первой книги должно быть установлено")
    }
}

// Переименованный Mock Bundle для тестирования загрузки данных
class TestMockBundle: Bundle { // Переименовано для избежания конфликта
    private let language: String
    
    init(language: String) {
        self.language = language
        super.init()
    }
    
    override func path(forResource name: String?, ofType ext: String?) -> String? {
        let fileName: String
        switch language {
        case "ru": fileName = "Books_ru"
        case "be": fileName = "Books_be"
        default: fileName = "Books_en" // По умолчанию английский
        }
        return Bundle.main.path(forResource: fileName, ofType: ext)
    }
}
