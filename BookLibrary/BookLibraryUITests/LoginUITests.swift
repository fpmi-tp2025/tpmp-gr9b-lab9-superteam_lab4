import XCTest

/// Класс для тестирования экрана авторизации через UI-тесты
class LoginUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        // Инициализируем приложение
        app = XCUIApplication()
        app.launch() // Запускаем приложение
        continueAfterFailure = false // Останавливаем тест при первой ошибке
    }
    
    override func tearDown() {
        // Добавляем задержку перед завершением
        sleep(1)
        app.terminate()
        super.tearDown()
    }
    
    /// Тест на успешную авторизацию
    func testSuccessfulLogin() {
        // Находим текстовые поля и кнопку входа
        let usernameTextField = app.textFields["login_placeholder"] // Поле для логина
        let passwordTextField = app.secureTextFields["password_placeholder"] // Поле для пароля
        let loginButton = app.buttons["login_button"] // Кнопка входа
        
        // Проверяем, что элементы найдены
        XCTAssertTrue(usernameTextField.exists, "Поле для логина не найдено")
        XCTAssertTrue(passwordTextField.exists, "Поле для пароля не найдено")
        XCTAssertTrue(loginButton.exists, "Кнопка входа не найдена")
        
        // Вводим данные
        usernameTextField.tap()
        usernameTextField.typeText("testUser")
        passwordTextField.tap()
        passwordTextField.typeText("testPass")
        
        // Нажимаем кнопку входа
        loginButton.tap()
        
        // Проверяем, что открылся экран с книгами
        let booksTitle = app.navigationBars.staticTexts["Library"]
        XCTAssertTrue(booksTitle.waitForExistence(timeout: 2), "Экран с книгами не открылся после авторизации")
    }
    
    /// Тест на обработку пустых полей при авторизации
    /// Тест на обработку пустых полей при авторизации
    func testEmptyFieldsAlert() {
        // Находим кнопку входа
        let loginButton = app.buttons["login_button"]
        
        // Проверяем, что кнопка найдена
        XCTAssertTrue(loginButton.exists, "Кнопка входа не найдена")
        
        // Нажимаем кнопку входа без заполнения полей
        loginButton.tap()
        
        // Добавляем задержку для отображения алерта
        sleep(1)
        
        // Ждем появления алерта
        let alert = app.alerts["Error"] // Используем конкретный заголовок алерта
        XCTAssertTrue(alert.waitForExistence(timeout: 2), "Алерт об ошибке не показан при пустых полях")
        
        // Проверяем заголовок и сообщение алерта
        XCTAssertEqual(alert.label, "Error", "Неверный заголовок алерта")
        XCTAssertEqual(alert.staticTexts.element(boundBy: 1).label, "Please fill all fields", "Неверное сообщение алерта")
    }
}
