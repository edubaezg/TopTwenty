import UIKit

class ProductResultViewCell: UITableViewCell {

    @IBOutlet weak var productStackView: UIStackView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var favoriteBackgroundView: UIView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func setup(title: String, price: String, description: String, thumbnail: String) {
        titleLabel.text = title
        priceLabel.text = price
        descriptionLabel.text = description
        thumbnailImageView.loadFrom(URLAddress: thumbnail)
        
        style()
    }
    
    func style() {
        thumbnailImageView.layer.cornerRadius = 4
        favoriteBackgroundView.layer.cornerRadius = 15
    }
    
    @IBAction func toggleFavoriteTapped(_ sender: Any) {
        // TODO: Save favorite in local memory
        let iconConfig = UIImage.SymbolConfiguration(scale: UIImage.SymbolScale.small)
        let favoriteIcon = UIImage(systemName: "heart.fill", withConfiguration: iconConfig)

        favoriteButton.setImage(favoriteIcon, for: .normal)
    }
    
}
