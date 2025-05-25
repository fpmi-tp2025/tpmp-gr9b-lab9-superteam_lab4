import XCTest
@testable import BookLibrary

/// Класс для тестирования поведения экрана авторизации при пустых полях
class LoginViewControllerEmptyFieldsTests: XCTestCase {
    
    var loginVC: MockLoginViewController! // Используем подкласс
    
    override func setUp() {
        super.setUp()
        // Инициализируем контроллер авторизации
        loginVC = MockLoginViewController()
        loginVC.loadViewIfNeeded() // Для инициализации UI-элементов
    }
    
    override func tearDown() {
        // Очищаем данные после выполнения теста
        UserDefaults.standard.removeObject(forKey: "isLoggedIn")
        UserDefaults.standard.removeObject(forKey: "username")
        UserDefaults.standard.synchronize()
        super.tearDown()
    }
    
    class MockLoginViewController: LoginViewController {
        var isAlertShown = false // Флаг для проверки вызова showAlert
        
        // Переопределяем метод showAlert
        override func showAlert(title: String, message: String) {
            super.showAlert(title: title, message: message)
            isAlertShown = true
        }
    }

    /// Тест на проверку поведения при пустых полях логина и пароля
    func testEmptyFieldsAlert() {
        // Подготовка: оставляем поля пустыми через методы
        loginVC.setUsername("")
        loginVC.setPassword("")
        
        // Действие: имитируем нажатие кнопки входа
        loginVC.loginButtonTapped()
        
        // Проверяем, что пользователь НЕ авторизован
        XCTAssertFalse(UserDefaults.standard.bool(forKey: "isLoggedIn"), "Пользователь не должен быть авторизован при пустых полях")
        
        // Проверяем, что алерт был показан
        XCTAssertTrue(loginVC.isAlertShown, "Алерт должен быть показан при пустых полях")
    }
}
