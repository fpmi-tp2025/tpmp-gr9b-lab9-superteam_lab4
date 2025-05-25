import XCTest
@testable import BookLibrary

class LoginViewControllerTests: XCTestCase {
    
    var loginVC: LoginViewController!
    
    /// Установка языка устройства для тестирования
    func setLanguage(_ language: String) {
        UserDefaults.standard.set([language], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize() // Сохраняем изменения
    }
    
    override func setUp() {
        super.setUp()
        loginVC = LoginViewController()
        loginVC.loadViewIfNeeded() // Для инициализации UI-элементов
        
        // Устанавливаем язык устройства на английский по умолчанию
        setLanguage("en")
    }
    
    override func tearDown() {
        super.tearDown()
        
        // Сбрасываем язык устройства и данные авторизации
        UserDefaults.standard.removeObject(forKey: "AppleLanguages")
        UserDefaults.standard.removeObject(forKey: "isLoggedIn")
        UserDefaults.standard.removeObject(forKey: "username")
        UserDefaults.standard.synchronize()
    }
    
    func testSuccessfulLogin() {
        // Подготовка: заполняем поля логина и пароля через методы
        loginVC.setUsername("testUser")
        loginVC.setPassword("testPass")
        
        // Действие: имитируем нажатие кнопки входа
        loginVC.loginButtonTapped()
        
        // Проверка: статус авторизации сохранен
        XCTAssertTrue(UserDefaults.standard.bool(forKey: "isLoggedIn"), "Статус авторизации не сохранен")
        XCTAssertEqual(UserDefaults.standard.string(forKey: "username"), "testUser", "Имя пользователя сохранено неверно")
    }
}
