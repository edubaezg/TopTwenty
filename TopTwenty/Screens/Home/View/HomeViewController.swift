import UIKit

// MARK: - HomeViewController
class HomeViewController: UIViewController {
    
    // MARK: - Properties
    let homeViewModel = HomeViewModel()
    let searchResultsVC = SearchResultsViewController()
    let activityIndicatorView = UIActivityIndicatorView()
    var searchController: UISearchController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
    }
}

// MARK: - Initial Methods
extension HomeViewController {
    func setup() {
        NavigationStyleHelper(navigationController: navigationController!).setNavigationBarStyle()
        searchController = UISearchController(searchResultsController: searchResultsVC)
        setSearchControllerView()
        activityIndicatorView.startAnimating()
        searchResultsVC.delegate = self
        getAccessToken()
    }
    
    func style() {
        // View
        view.backgroundColor = UIColor(named: "background")
        
        // ActivityIndicator
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        // SearchController
        searchController?.searchBar.tintColor = .black
        searchController?.searchBar.searchTextField.layer.cornerRadius = 18
        searchController?.searchBar.searchTextField.layer.masksToBounds = true
        searchController?.searchBar.searchTextField.backgroundColor = .white
    }
    
    func layout() {
        view.addSubview(activityIndicatorView)
        
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

// MARK: - Methods
extension HomeViewController {
    func setSearchControllerView() {
        searchController?.showsSearchResultsController = true
        searchController?.searchBar.delegate = searchResultsVC.self
        searchController?.searchBar.placeholder = "Buscar en Mercado Libre"
        searchController?.searchBar.setValue("Cancelar", forKey: "cancelButtonText")
    }
    
    func getAccessToken() {
        homeViewModel.getAccessToken { didTokenSaved in
            if !didTokenSaved {
                // TODO: Show home error
                self.activityIndicatorView.stopAnimating()
                self.title = "Inicio"
            } else {
                self.activityIndicatorView.stopAnimating()
                self.title = "Inicio"
                self.navigationItem.searchController = self.searchController
            }
        }
    }
}

// MARK: - SearchResultsDelegate
extension HomeViewController: SearchResultsDelegate {
    func goToProductResults(category: CategoryModel) {
        let productResultsVC = ProductResultsViewController(categoryId: category.categoryId)
        navigationController?.pushViewController(productResultsVC, animated: true)
    }
}
