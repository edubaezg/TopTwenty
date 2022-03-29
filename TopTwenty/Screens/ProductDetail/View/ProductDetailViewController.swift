import UIKit

class ProductDetailViewController: UIViewController {
    
    var navStyle: NavigationStyleHelper!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Methods
extension ProductDetailViewController {
    func setup() {
        title = "Detalle"
        NavigationStyleHelper(navigationController: navigationController!).setNavigationBarStyle()
    }
    
    func setyle() {
        
    }
    
    func layout() {
        
    }
}
