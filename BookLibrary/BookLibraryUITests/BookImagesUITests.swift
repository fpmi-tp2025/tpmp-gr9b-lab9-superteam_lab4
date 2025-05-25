import XCTest

/// Класс для тестирования отображения изображений книг
class BookImagesUITests: XCTestCase {
    
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
    
    /// Тест на проверку изображений в списке книг
    func testBookImagesInList() {
        let collectionView = app.collectionViews["books_collection_view"]
        XCTAssertTrue(collectionView.exists, "Коллекция книг не найдена")
        
        let firstCell = collectionView.cells.element(boundBy: 0)
        let bookImageView = firstCell.images.element(boundBy: 0)
        XCTAssertTrue(bookImageView.exists, "Изображение первой книги не отображается")
    }
    
    /// Тест на проверку изображения на экране деталей книги
    func testBookImageInDetails() {
        let firstCell = app.collectionViews.cells.element(boundBy: 0)
        firstCell.tap()
        
        let bookImageView = app.images["book_image_view"]
        XCTAssertTrue(bookImageView.exists, "Изображение книги не отображается на экране деталей")
    }
}
