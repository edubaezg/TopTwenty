import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        let favoritesVC = UINavigationController(rootViewController: FavoritesViewController())
        
        // Set Bar Items
        homeVC.tabBarItem = UITabBarItem(title: "Inicio", image: UIImage(systemName: "house"), tag: 1)
        favoritesVC.tabBarItem = UITabBarItem(title: "Favoritos", image: UIImage(systemName: "heart"), tag: 2)
        
        self.tabBar.backgroundColor = .white
        self.setViewControllers([homeVC, favoritesVC], animated: false)
    }
}
