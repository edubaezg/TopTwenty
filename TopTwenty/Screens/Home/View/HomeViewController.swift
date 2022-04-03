import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let homeViewModel = HomeViewModel()
    let searchResultsVC = SearchResultsViewController()
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
        searchController?.showsSearchResultsController = true
        searchController?.searchBar.delegate = searchResultsVC.self

        searchResultsVC.delegate = self
        
        //getAccessToken()
        self.title = "Inicio"
        
        self.navigationItem.searchController = self.searchController
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
    }
}

// MARK: - Methods
extension HomeViewController {
    func getAccessToken() {
        homeViewModel.getAccessToken { didTokenSaved in
            if !didTokenSaved {
                // TODO: SHOW ERROR
                print("TODO: SHOW ERROR")
                self.activityIndicator.stopAnimating()
                self.title = "Inicio"
                
                self.navigationItem.searchController = self.searchController
            } else {
                self.activityIndicator.stopAnimating()
                self.title = "Inicio"
                self.navigationItem.searchController = self.searchController
            }
        }
    }
}

// MARK: - SearchResultsDelegate
extension HomeViewController: SearchResultsDelegate {
    func goToProductResults(category: CategoryModel) {
        navigationController?.pushViewController(ProductResultsViewController(categoryId: category.category_id), animated: true)
    }
}
