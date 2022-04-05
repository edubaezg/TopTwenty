import UIKit

// MARK: - ProductResultsViewController
class ProductResultsViewController: UIViewController {
    // MARK: - Properties
    let activityIndicatorView = UIActivityIndicatorView()
    let cellIdentifier = "ProductResultViewCell"
    let productsTableView = UITableView()
    let productResultsViewModel = ProductResultViewModel()
    var categoryId: String
    var products = [Product]()
    
    
    // MARK: - Inits
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
    }
    
    init(categoryId: String) {
        self.categoryId = categoryId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Initial Methods
extension ProductResultsViewController {
    func setup() {
        title = "Top 20"
        
        // ProductsTableView
        productsTableView.delegate = self
        productsTableView.dataSource = self
        productsTableView.register(UINib(nibName: cellIdentifier, bundle: .main), forCellReuseIdentifier: cellIdentifier)
        
        // ActivityIndicatorView
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.startAnimating()
        
        getProductsByCategory()
    }
    
    func style() {
        view.backgroundColor = UIColor(named: "background")
        
        // ProductsTableView
        productsTableView.translatesAutoresizingMaskIntoConstraints = false
        productsTableView.separatorStyle = .none
        productsTableView.focusEffect = .none
        productsTableView.isHidden = true
        
        // ActivityIndicatorView
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        view.addSubview(productsTableView)
        view.addSubview(activityIndicatorView)
        
        // ProductsTableView
        NSLayoutConstraint.activate([
            productsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            productsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: productsTableView.trailingAnchor),
            productsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        //ActivityIndicatorView
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

// MARK: - Methods
extension ProductResultsViewController {
    func getProductsByCategory() {
        productResultsViewModel.getTopTwenty(withCategoryId: categoryId) { products in
            self.products = products
            self.productsTableView.reloadData()
            self.productsTableView.isHidden = false
            self.activityIndicatorView.stopAnimating()
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ProductResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? ProductResultViewCell else { return UITableViewCell() }
        let product = products[indexPath.row]
        
        cell.delegate = self
        cell.setup(product: product)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productDetailVC = ProductDetailViewController(product: products[indexPath.row])
        navigationController?.pushViewController(productDetailVC, animated: true)
    }
}

// MARK: - ProductResultDelegate
extension ProductResultsViewController: ProductResultDelegate {
    func addFavorite(productId: String) {
        for index in 0..<products.count {
            if products[index].id == productId { products[index].isFavorite = true }
        }
        
        productResultsViewModel.addFavorite(productId: productId)
    }
    
    func deleteFavorite(productId: String) {
        for index in 0..<products.count {
            if products[index].id == productId { products[index].isFavorite = false }
        }
        
        productResultsViewModel.deleteFavorite(productId: productId)
    }
}
