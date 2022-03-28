import UIKit

class HomeViewController: UIViewController {
    var navStyle: NavigationStyleHelper!
    let searchController = UISearchController(searchResultsController: SearchResultsViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
    }
}

// MARK: - Methods
extension HomeViewController {
    func setup() {
        title = "Inicio"
        
        NavigationStyleHelper(navigationController: navigationController!).setNavigationBarStyle()
        
        searchController.searchResultsUpdater = self
        searchController.showsSearchResultsController = true
    }
    
    func style() {
        // View
        view.backgroundColor = UIColor(named: "background")
        
        // SearchController
        searchController.searchBar.tintColor = .black
        searchController.searchBar.searchTextField.layer.cornerRadius = 18
        searchController.searchBar.searchTextField.layer.masksToBounds = true
        searchController.searchBar.searchTextField.backgroundColor = .white
    }
    
    func layout() {
        // SearchController
        searchController.searchBar.placeholder = "Buscar en Mercado Libre"
        searchController.searchBar.setValue("Cancelar", forKey: "cancelButtonText")
        navigationItem.searchController = searchController
    }
}

// MARK: - UISearchResultsUpdating
extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let search = searchController.searchBar.text else { return }
        print("search: \(search)")
    }
}

// MARK: - SearchResultsDelegate
/*extension HomeViewController: SearchResultsDelegate {
    func goToProductResults() {
        print("Gooo!!!!")
        navigationController?.pushViewController(ProductResultsViewController(), animated: true)
    }
}*/
