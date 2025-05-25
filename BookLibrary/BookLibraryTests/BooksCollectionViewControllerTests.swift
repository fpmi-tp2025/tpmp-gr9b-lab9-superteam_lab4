import XCTest
@testable import BookLibrary

class BooksCollectionViewControllerTests: XCTestCase {
    
    var booksVC: BooksCollectionViewController!
    
    override func setUp() {
        super.setUp()
        booksVC = BooksCollectionViewController()
        booksVC.loadViewIfNeeded() // Для инициализации UI-элементов
    }
    
    func testLoadEnglishBooks() {
        // Подменяем язык через MockBundle
        let mockBundle = MockBundle(language: "en")
        
        // Загружаем данные через MockBundle
        booksVC.loadBooks(from: mockBundle, language: "en")
        
        // Проверяем количество загруженных книг
        XCTAssertEqual(booksVC.books.count, 3, "Неверное количество книг")
        
        // Проверяем локализацию первой книги
        XCTAssertEqual(booksVC.books.first?.title, "War and Peace", "Неверная локализация")
    }
    
    func testMissingFileHandling() {
        // Используем MockBundle без указания языка (имитируем отсутствие файла)
        let mockBundle = MockBundle()
        booksVC.loadBooks(from: mockBundle) // Загружаем данные
        
        // Проверяем, что массив книг пустой при ошибке загрузки
        XCTAssertTrue(booksVC.books.isEmpty, "Данные не должны загружаться при ошибке")
    }
}

// Mock Bundle для тестирования загрузки данных
class MockBundle: Bundle {
    private let language: String?
    
    init(language: String? = nil) {
        self.language = language
        super.init()
    }
    
    override func path(forResource name: String?, ofType ext: String?) -> String? {
        guard let language = language else {
            return nil // Имитируем отсутствие файла
        }
        
        // Определяем имя файла в зависимости от языка
        let fileName: String
        switch language {
        case "ru": fileName = "Books_ru"
        case "be": fileName = "Books_be"
        default: fileName = "Books_en"
        }
        
        // Возвращаем путь к файлу
        return Bundle.main.path(forResource: fileName, ofType: ext)
    }
}
