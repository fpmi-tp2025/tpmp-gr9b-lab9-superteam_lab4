import XCTest

/// Класс для тестирования навигации "Назад"
class NavigationBackUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launch()
        continueAfterFailure = false
        
        // Авторизуемся
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
        app.terminate()
        super.tearDown()
    }
    
    /// Тест на проверку навигации "Назад"
    func testBackNavigation() {
        // Переходим на экран деталей книги
        let firstCell = app.collectionViews.cells.element(boundBy: 0)
        firstCell.tap()
        
        // Проверяем, что открылся экран деталей книги
        let titleLabel = app.staticTexts["War and Peace"]
        XCTAssertTrue(titleLabel.exists, "Экран деталей книги не открылся")
        
        // Нажимаем кнопку "Назад"
        app.navigationBars.buttons.element(boundBy: 0).tap()
        
        // Проверяем, что вернулись на экран списка книг
        let booksTitle = app.navigationBars.staticTexts["Library"]
        XCTAssertTrue(booksTitle.exists, "Экран списка книг не открылся после нажатия 'Назад'")
    }
}
