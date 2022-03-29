import UIKit

class ProductResultViewCell: UITableViewCell {

    @IBOutlet weak var productStackView: UIStackView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var favoriteBackgroundView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func setup(name: String, price: String, description: String) {
        nameLabel.text = name
        priceLabel.text = price
        descriptionLabel.text = description
        
        style()
    }
    
    func style() {
        thumbnailImageView.layer.cornerRadius = 4
        favoriteBackgroundView.layer.cornerRadius = 15
    }
}
