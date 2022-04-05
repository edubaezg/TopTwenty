import UIKit

// MARK: - FavoritesViewController
class FavoritesViewController: UIViewController {
    // MARK: - @IBOutlets
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var emptyFavoritesStackView: UIStackView!
    
    // MARK: - Properties
    let cellIdentifier = "FavoriteViewCell"
    let productsTableView = UITableView()
    let favoritesViewModel = FavoritesViewModel()
    var products = [Product]()
    
}

// MARK: - Inits
extension FavoritesViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
    }

    override func viewDidAppear(_ animated: Bool) {
        getFavorites()
    }
}

// MARK: - Initial Methods
extension FavoritesViewController {
    func setup() {
        title = "Favoritos"
        NavigationStyleHelper(navigationController: navigationController!).setNavigationBarStyle()
        
        productsTableView.delegate = self
        productsTableView.dataSource = self
        productsTableView.register(UINib(nibName: cellIdentifier, bundle: .main), forCellReuseIdentifier: cellIdentifier)
    }
    
    func style() {
        // View
        view.backgroundColor = UIColor(named: "background")
        
        // ProductsTableView
        productsTableView.translatesAutoresizingMaskIntoConstraints = false
        productsTableView.separatorStyle = .none
        productsTableView.focusEffect = .none
        productsTableView.isHidden = true
    }
    
    func layout() {
        view.addSubview(productsTableView)
        
        // ProductsTableView
        NSLayoutConstraint.activate([
            productsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            productsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: productsTableView.trailingAnchor),
            productsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - Methods
extension FavoritesViewController {
    func getFavorites() {
        activityIndicatorView.startAnimating()
        favoritesViewModel.getFavorites(currentProducts: products.count) { productsResults in
            guard let products = productsResults else { return }
            
            if products.count == 0 {
                self.emptyFavoritesStackView.isHidden = false
            } else {
                self.products = products
                self.productsTableView.reloadData()
                self.productsTableView.isHidden = false
            }
            self.activityIndicatorView.stopAnimating()
        }
    }
    
    func deleteFavorite(index: Int) {
        favoritesViewModel.deleteFavorite(productId: products[index].id)
        products.remove(at: index)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? FavoriteViewCell else { return UITableViewCell() }
        let product = products[indexPath.row]
        
        cell.setup(product: product)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(ProductDetailViewController(product: products[indexPath.row]), animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteFavorite(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
