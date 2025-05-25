import XCTest
@testable import BookLibrary

class DetailViewControllerTests: XCTestCase {
    
    var detailVC: DetailViewController!
    
    override func setUp() {
        super.setUp()
        detailVC = DetailViewController()
        detailVC.book = Book(
            title: "Test Title",
            author: "Test Author",
            description: "Test Description",
            imageName: "test_image" // Убедитесь, что такое изображение добавлено в Assets.xcassets
        )
        detailVC.loadViewIfNeeded() // Для инициализации UI-элементов
    }
    
    func testBookDetailsDisplayedCorrectly() {
        // Проверяем заголовок экрана
        XCTAssertEqual(detailVC.title, "Test Title", "Заголовок экрана не соответствует названию книги")
        
        // Проверяем изображение книги
        XCTAssertNotNil(detailVC.bookImageView.image, "Изображение книги должно быть установлено")
        
        // Проверяем название книги
        XCTAssertEqual(detailVC.titleLabel.text, "Test Title", "Название книги отображается неверно")
        
        // Проверяем автора книги
        XCTAssertEqual(detailVC.authorLabel.text, "Author: Test Author", "Автор книги отображается неверно")
        
        // Проверяем описание книги
        XCTAssertEqual(detailVC.descriptionLabel.text, "Test Description", "Описание книги отображается неверно")
    }
}
