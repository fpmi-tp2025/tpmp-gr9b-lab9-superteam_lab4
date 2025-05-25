import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Инициализация окна
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // Проверка авторизации
        if UserDefaults.standard.bool(forKey: "isLoggedIn") {
            // Пользователь авторизован - показываем экран книг
            window?.rootViewController = UINavigationController(rootViewController: BooksCollectionViewController())
        } else {
            // Пользователь не авторизован - показываем экран входа
            window?.rootViewController = LoginViewController()
        }
        
        window?.makeKeyAndVisible()
        return true
    }
}
