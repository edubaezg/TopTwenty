import UIKit

class ProductResultsViewController: UIViewController {

    let activityIndicatorView = UIActivityIndicatorView()
    let cellIdentifier = "ProductResultViewCell"
    let productsTableView = UITableView()
    let productResultsViewModel = ProductResultViewModel()
    var categoryId: String
    var products = [Product]()
    
    
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
        
        productsTableView.delegate = self
        productsTableView.dataSource = self
        productsTableView.register(UINib(nibName: cellIdentifier, bundle: .main), forCellReuseIdentifier: cellIdentifier)
        
        productsTableView.isHidden = true
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.startAnimating()
        
        getProductsByCategory()
    }
    
    func style() {
        view.backgroundColor = UIColor(named: "background")
        
        productsTableView.translatesAutoresizingMaskIntoConstraints = false
        productsTableView.separatorStyle = .none
        productsTableView.focusEffect = .none
        
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
        print(product.thumbnail)
        cell.setup(title: product.title, price: "$ \(product.price)", description: "Vendido por Nintendo", thumbnail: product.thumbnail)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(ProductDetailViewController(product: products[indexPath.row]), animated: true)
    }
}
