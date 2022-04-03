import UIKit

class FavoritesViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
    }
}

// MARK: - Methods
extension FavoritesViewController {
    func setup() {
        title = "Favoritos"
        NavigationStyleHelper(navigationController: navigationController!).setNavigationBarStyle()
    }
    
    func style() {
        // View
        view.backgroundColor = UIColor(named: "background")
    }
    
    func layout() {
        
    }
}
