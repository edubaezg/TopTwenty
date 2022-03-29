import UIKit

class ProductResultsViewController: UIViewController {

    let cellIdentifier = "ProductResultViewCell"
    let productsTableView = UITableView()
    var navStyle: NavigationStyleHelper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
    }
}

// MARK: - Methods
extension ProductResultsViewController {
    func setup() {
        title = "Resultados"
        
        NavigationStyleHelper(navigationController: navigationController!).setNavigationBarStyle()
        
        productsTableView.delegate = self
        productsTableView.dataSource = self
        productsTableView.register(UINib(nibName: cellIdentifier, bundle: .main), forCellReuseIdentifier: cellIdentifier)
    }
    
    func style() {
        view.backgroundColor = UIColor(named: "background")
        
        productsTableView.translatesAutoresizingMaskIntoConstraints = false
        productsTableView.separatorStyle = .none
        productsTableView.focusEffect = .none
    }
    
    func layout() {
        view.addSubview(productsTableView)
        
        NSLayoutConstraint.activate([
            productsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            productsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: productsTableView.trailingAnchor),
            productsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ProductResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? ProductResultViewCell else { return UITableViewCell() }
        cell.setup(name: "Nintendo Switch OLED 64GB Standard color blanco y negro", price: "$ 418.990", description: "Vendido por Nintendo")
        return cell
    }
}
