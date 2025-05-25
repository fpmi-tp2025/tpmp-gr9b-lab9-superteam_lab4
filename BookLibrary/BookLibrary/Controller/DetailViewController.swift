import UIKit

/// Контроллер для отображения детальной информации о книге
class DetailViewController: UIViewController {
    
    // MARK: - Свойства
    var book: Book! // Книга для отображения
    
    // MARK: - UI Элементы
    let scrollView = UIScrollView() // Скролл для контента
    let contentView = UIView() // Контейнер для контента
    
    let bookImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews() // Настройка интерфейса
        configureWithBook() // Заполнение данными
    }
    
    // MARK: - Настройка интерфейса
    private func setupViews() {
        // Добавление элементов
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(bookImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(authorLabel)
        contentView.addSubview(descriptionLabel)
        
        // Установка accessibilityIdentifier
        bookImageView.accessibilityIdentifier = "book_image_view"
        titleLabel.accessibilityIdentifier = "book_title_label"
        authorLabel.accessibilityIdentifier = "book_author_label"
        descriptionLabel.accessibilityIdentifier = "book_description_label"
        
        // Настройка Auto Layout
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        bookImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            // Констрейнты для scrollView
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // Констрейнты для contentView
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Констрейнты для изображения книги
            bookImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            bookImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            bookImageView.widthAnchor.constraint(equalToConstant: 200),
            bookImageView.heightAnchor.constraint(equalToConstant: 300),
            
            // Констрейнты для заголовка
            titleLabel.topAnchor.constraint(equalTo: bookImageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Констрейнты для автора
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Констрейнты для описания
            descriptionLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    // MARK: - Заполнение данными
    private func configureWithBook() {
        title = book.title
        bookImageView.image = UIImage(named: book.imageName)
        titleLabel.text = book.title
        authorLabel.text = String(format: NSLocalizedString("book_author", comment: ""), book.author)
        descriptionLabel.text = book.description
    }
}
