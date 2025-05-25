import XCTest

/// Класс для тестирования экрана списка книг через UI-тесты
class BooksListUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        // Инициализируем приложение
        app = XCUIApplication()
        app.launch() // Запускаем приложение
        continueAfterFailure = false // Останавливаем тест при первой ошибке
        
        // Авторизуемся перед тестированием экрана книг
        let usernameTextField = app.textFields["login_placeholder"]
        let passwordTextField = app.secureTextFields["password_placeholder"]
        let loginButton = app.buttons["login_button"]
        
        usernameTextField.tap()
        usernameTextField.typeText("testUser")
        passwordTextField.tap()
        passwordTextField.typeText("testPass")
        loginButton.tap()
    }
    
    override func tearDown() {
        // Закрываем приложение после завершения теста
        app.terminate()
        super.tearDown()
    }
    
    /// Тест на проверку отображения списка книг
    func testBooksDisplayedCorrectly() {
        // Проверяем, что коллекция содержит ячейки
        let collectionView = app.collectionViews["books_collection_view"]
        XCTAssertTrue(collectionView.exists, "Коллекция книг не найдена")
        
        // Проверяем количество ячеек
        let cells = collectionView.cells
        XCTAssertEqual(cells.count, 3, "Неверное количество книг в коллекции")
        
        // Проверяем название первой книги
        let firstCell = cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.staticTexts["War and Peace"].exists, "Название первой книги отображается неверно")
    }
    
    /// Тест на проверку перехода к деталям книги
    func testBookDetailsNavigation() {
        // Находим первую ячейку и нажимаем на нее
        let firstCell = app.collectionViews.cells.element(boundBy: 0)
        firstCell.tap()
        
        // Проверяем, что открылся экран деталей книги
        let titleLabel = app.staticTexts["War and Peace"]
        XCTAssertTrue(titleLabel.exists, "Экран деталей книги не открылся")
        
        // Проверяем изображение книги
        let bookImageView = app.images["book_image_view"]
        XCTAssertTrue(bookImageView.exists, "Изображение книги не отображается")
    }
}
