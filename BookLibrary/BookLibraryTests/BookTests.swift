import XCTest
@testable import BookLibrary

class BookTests: XCTestCase {
    
    func testBookInitialization() {
        // Создаем объект книги
        let book = Book(
            title: "Test Title",
            author: "Test Author",
            description: "Test Description",
            imageName: "test_image"
        )
        
        // Проверяем корректность инициализации свойств книги
        XCTAssertEqual(book.title, "Test Title", "Некорректное название книги")
        XCTAssertEqual(book.author, "Test Author", "Некорректный автор")
        XCTAssertEqual(book.description, "Test Description", "Некорректное описание")
        XCTAssertEqual(book.imageName, "test_image", "Некорректное имя изображения")
    }
}
