import UIKit

/// Кастомная ячейка для отображения книги в коллекции
class BookCell: UICollectionViewCell {
    
    // MARK: - UI Элементы
    let imageView: UIImageView = { // Изменено на internal для тестов
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    let titleLabel: UILabel = { // Изменено на internal для тестов
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    // MARK: - Инициализация
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews() // Настройка интерфейса
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Настройка интерфейса
    private func setupViews() {
        backgroundColor = .systemGray6
        layer.cornerRadius = 12
        
        // Добавление элементов
        addSubview(imageView)
        addSubview(titleLabel)
        
        // Настройка Auto Layout
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Констрейнты для изображения
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7),
            
            // Констрейнты для заголовка
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
    
    // MARK: - Наполнение данными
    func configure(with book: Book) {
        titleLabel.text = book.title
        imageView.image = UIImage(named: book.imageName)
    }
}
