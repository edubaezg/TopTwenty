import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var navStyle: NavigationStyleHelper!
    let searchResultsVC = SearchResultsViewController()
    var searchController: UISearchController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController = UISearchController(searchResultsController: searchResultsVC)
        setup()
        style()
        layout()
    }
}

// MARK: - Methods
extension HomeViewController {
    func setup() {
        
        
        NavigationStyleHelper(navigationController: navigationController!).setNavigationBarStyle()
        
        searchController?.searchResultsUpdater = self
        searchController?.showsSearchResultsController = true
        
        searchResultsVC.delegate = self
    }
    
    func style() {
        // View
        view.backgroundColor = UIColor(named: "background")
        
        // SearchController
        searchController?.searchBar.tintColor = .black
        searchController?.searchBar.searchTextField.layer.cornerRadius = 18
        searchController?.searchBar.searchTextField.layer.masksToBounds = true
        searchController?.searchBar.searchTextField.backgroundColor = .white
    }
    
    func layout() {
        // SearchController
        searchController?.searchBar.placeholder = "Buscar en Mercado Libre"
        searchController?.searchBar.setValue("Cancelar", forKey: "cancelButtonText")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.title = "Inicio"
            self.navigationItem.searchController = self.searchController
            self.activityIndicator.stopAnimating()
        }
    }
}

// MARK: - UISearchResultsUpdating
extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let search = searchController.searchBar.text else { return }
        // TODO: Search Api
        print(search)
    }
}

// MARK: - SearchResultsDelegate
extension HomeViewController: SearchResultsDelegate {
    func goToProductResults() {
        navigationController?.pushViewController(ProductResultsViewController(), animated: true)
    }
}
