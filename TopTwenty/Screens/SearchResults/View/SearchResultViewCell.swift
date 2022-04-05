import UIKit

// MARK: - SearchResultViewCell
class SearchResultViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    func setup(category: CategoryModel) {
        nameLabel.text = category.domainName
    }
    
}
