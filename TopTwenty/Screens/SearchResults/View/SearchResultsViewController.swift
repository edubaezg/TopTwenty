import UIKit

// MARK: - Protocol
protocol SearchResultsDelegate: AnyObject {
    func goToProductResults(category: CategoryModel)
}

// MARK: SearchResultsViewController
class SearchResultsViewController: UIViewController {
    
    // MARK: Properties
    let cellIdentifier = "SearchResultViewCell"
    let searchResultsTableView = UITableView()
    let searchResultsViewModel = SearchResultsViewModel()
    var categories = [CategoryModel]()
    weak var delegate: SearchResultsDelegate?
}

// MARK: - Inits
extension SearchResultsViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
    }
}

// MARK: - Methods
extension SearchResultsViewController {
    func setup() {
        searchResultsTableView.delegate = self
        searchResultsTableView.dataSource = self
        searchResultsTableView.register(UINib(nibName: cellIdentifier, bundle: .main), forCellReuseIdentifier: cellIdentifier)
    }
    
    func style() {
        // SearchResultsTableView
        searchResultsTableView.translatesAutoresizingMaskIntoConstraints = false
        searchResultsTableView.separatorStyle = .none
    }
    
    func layout() {
        view.addSubview(searchResultsTableView)
        
        // SearchResultsTableView
        NSLayoutConstraint.activate([
            searchResultsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            searchResultsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchResultsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchResultsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? SearchResultViewCell else {
            return UITableViewCell()
        }
        
        cell.setup(category: categories[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.goToProductResults(category: categories[indexPath.row])
    }
}

// MARK: - UISearchBarDelegate
extension SearchResultsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let search = searchBar.text else { return }
        searchResultsViewModel.getCategoryPreditor(search: search) { categories in
            self.categories = categories
            self.searchResultsTableView.reloadData()
        }
    }
}
