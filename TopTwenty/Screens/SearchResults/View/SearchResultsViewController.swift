import UIKit

/*protocol SearchResultsDelegate: AnyObject {
    func goToProductResults()
}*/

class SearchResultsViewController: UIViewController {

    let searchResultsTableView = UITableView()

    //weak var delegate: SearchResultsDelegate?
    
    let searchResultCellIdentifier = "SearchResultTableViewCell"
    
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
        searchResultsTableView.register(UINib(nibName: searchResultCellIdentifier, bundle: .main), forCellReuseIdentifier: searchResultCellIdentifier)
    }
    
    func style() {
        searchResultsTableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        view.addSubview(searchResultsTableView)
        
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
        6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: searchResultCellIdentifier) as? SearchResultTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt")
        //delegate?.goToProductResults()
    }
}
