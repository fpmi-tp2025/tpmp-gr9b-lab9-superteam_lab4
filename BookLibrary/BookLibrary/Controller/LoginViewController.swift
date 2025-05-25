import UIKit

/// Контроллер для экрана авторизации
class LoginViewController: UIViewController {
    
    // MARK: - UI Элементы
    private let usernameTextField = UITextField() // Поле для ввода логина (доступно только внутри класса)
    private let passwordTextField = UITextField() // Поле для ввода пароля (доступно только внутри класса)
    let loginButton = UIButton(type: .system) // Кнопка входа (доступна только внутри класса)
    
    // MARK: - Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI() // Настройка интерфейса
        setupConstraints() // Настройка констрейнтов
    }
    
    // MARK: - Настройка интерфейса
    private func setupUI() {
        view.backgroundColor = .white
        
        // Настройка поля логина
        usernameTextField.placeholder = NSLocalizedString("login_placeholder", comment: "")
        usernameTextField.borderStyle = .roundedRect
        usernameTextField.autocapitalizationType = .none
        usernameTextField.accessibilityIdentifier = "login_placeholder" // Добавляем идентификатор
        
        // Настройка поля пароля
        passwordTextField.placeholder = NSLocalizedString("password_placeholder", comment: "")
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        passwordTextField.accessibilityIdentifier = "password_placeholder" // Добавляем идентификатор
        
        // Настройка кнопки входа
        loginButton.setTitle(NSLocalizedString("login_button", comment: ""), for: .normal)
        loginButton.backgroundColor = .systemBlue
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 8
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginButton.accessibilityIdentifier = "login_button" // Добавляем идентификатор
        
        // Добавление элементов на экран
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
    }
    
    // MARK: - Настройка констрейнтов
    private func setupConstraints() {
        // Активация Auto Layout
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Позиционирование поля логина
            usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
            usernameTextField.widthAnchor.constraint(equalToConstant: 250),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // Позиционирование поля пароля
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: usernameTextField.widthAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: usernameTextField.heightAnchor),
            
            // Позиционирование кнопки входа
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalTo: usernameTextField.widthAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    // MARK: - Обработка нажатия кнопки входа
    @objc func loginButtonTapped() {
        // Проверка заполнения полей
        guard
            let username = usernameTextField.text, !username.isEmpty,
            let password = passwordTextField.text, !password.isEmpty
        else {
            // Показываем алерт об ошибке
            showAlert(title: NSLocalizedString("error_title", comment: ""),
                      message: NSLocalizedString("login_error", comment: ""))
            return
        }
        // Сохраняем данные авторизации
        UserDefaults.standard.set(username, forKey: "username")
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        
        // Переходим к экрану с книгами
        let booksVC = BooksCollectionViewController()
        let navController = UINavigationController(rootViewController: booksVC)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
    
    // MARK: - Показ алерта
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        // Гарантируем выполнение на главном потоке
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - Методы для тестирования
    func setUsername(_ username: String) {
        usernameTextField.text = username
    }
    
    func setPassword(_ password: String) {
        passwordTextField.text = password
    }
    
    func getUsernamePlaceholder() -> String? {
        return usernameTextField.placeholder
    }
    
    func getPasswordPlaceholder() -> String? {
        return passwordTextField.placeholder
    }
}
