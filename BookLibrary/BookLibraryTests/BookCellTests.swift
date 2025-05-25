import XCTest
@testable import BookLibrary

class BookCellTests: XCTestCase {
    
    func testBookCellConfiguration() {
        // Создаем ячейку с фиксированным размером
        let cell = BookCell(frame: CGRect(x: 0, y: 0, width: 160, height: 200))
        
        // Создаем тестовую книгу
        let book = Book(
            title: "Test Title",
            author: "Test Author",
            description: "Test Description",
            imageName: "test_image"
        )
        
        // Наполняем ячейку данными
        cell.configure(with: book)
        
        // Проверяем текст заголовка
        XCTAssertEqual(cell.titleLabel.text, "Test Title", "Неверное название книги в ячейке")
        
        // Проверяем наличие изображения
        XCTAssertNotNil(cell.imageView.image, "Изображение должно быть установлено")
        
        // Проверяем цвет фона ячейки
        XCTAssertEqual(cell.backgroundColor, UIColor.systemGray6, "Цвет фона ячейки неверный")
        
        // Проверяем скругление углов
        XCTAssertEqual(cell.layer.cornerRadius, 12, "Скругление углов ячейки неверное")
    }
    
    func testImageViewPlaceholder() {
        // Создаем ячейку с фиксированным размером
        let cell = BookCell(frame: CGRect(x: 0, y: 0, width: 160, height: 200))
        
        // Создаем тестовую книгу без изображения
        let book = Book(
            title: "Test Title",
            author: "Test Author",
            description: "Test Description",
            imageName: "non_existent_image"
        )
        
        // Наполняем ячейку данными
        cell.configure(with: book)
        
        // Проверяем, что изображение использует placeholder (фоновый цвет)
        XCTAssertEqual(cell.imageView.backgroundColor, UIColor.lightGray, "Placeholder изображения отсутствует")
    }
}
