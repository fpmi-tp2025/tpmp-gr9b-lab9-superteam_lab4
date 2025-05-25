import XCTest
@testable import BookLibrary

class LocalizationTests: XCTestCase {
    
    var booksVC: BooksCollectionViewController!
    var loginVC: LoginViewController!
    
    /// Мок бандл для тестирования локализации
    class MockBundle: Bundle {
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
    
    override func setUp() {
        super.setUp()
        booksVC = BooksCollectionViewController()
        loginVC = LoginViewController()
        booksVC.loadViewIfNeeded()
        loginVC.loadViewIfNeeded()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testEnglishLocalization() {
        // Создаем MockBundle для английского языка
        let mockBundle = MockBundle(language: "en")
        // Загружаем данные для английского языка
        booksVC.loadBooks(from: mockBundle, language: "en")
        
        // Проверяем заголовок навигационной панели
        XCTAssertEqual(booksVC.title, "Library", "Неверная локализация заголовка")
        
        // Проверяем количество книг
        XCTAssertEqual(booksVC.books.count, 3, "Неверное количество книг")
        XCTAssertEqual(booksVC.books.first?.title, "War and Peace", "Неверная локализация названия книги")
        
        // Проверяем placeholder для полей авторизации
        XCTAssertEqual(loginVC.getUsernamePlaceholder(), "Username", "Неверная локализация placeholder для логина")
        XCTAssertEqual(loginVC.getPasswordPlaceholder(), "Password", "Неверная локализация placeholder для пароля")
        
        // Проверяем локализацию кнопки входа
        XCTAssertEqual(loginVC.loginButton.title(for: .normal), "Login", "Неверная локализация кнопки входа")
    }
}
