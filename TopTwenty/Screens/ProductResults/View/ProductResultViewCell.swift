import UIKit

// MARK: - ProductResultDelegate
protocol ProductResultDelegate: AnyObject {
    func addFavorite(productId: String)
    func deleteFavorite(productId: String)
}

// MARK: - ProductResultViewCell
class ProductResultViewCell: UITableViewCell {
    // MARK: - @IBOutlet
    @IBOutlet weak var productStackView: UIStackView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var favoriteBackgroundView: UIView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - Properties
    var productId = ""
    var isFavorite: Bool = false
    weak var delegate: ProductResultDelegate?
}

// MARK: - Initial Methods
extension ProductResultViewCell {
    func setup(product: Product) {
        productId = product.id
        titleLabel.text = product.title
        priceLabel.text = String("$ \(product.price)")
        descriptionLabel.text = "Vendido por Nintendo"
        thumbnailImageView.loadFrom(URLAddress: product.thumbnail)
        isFavorite = product.isFavorite ?? false
        setFavoriteButtonView(isFavorite: isFavorite)
        
        style()
    }
    
    func style() {
        thumbnailImageView.layer.cornerRadius = 4
        favoriteBackgroundView.layer.cornerRadius = 15
    }
}

// MARK: - Methods
extension ProductResultViewCell {
    func addFavorite() {
        delegate?.addFavorite(productId: productId)
        setFavoriteButtonView(isFavorite: true)
    }
    
    func deleteFavorite() {
        delegate?.deleteFavorite(productId: productId)
        setFavoriteButtonView(isFavorite: false)
    }
    
    func setFavoriteButtonView(isFavorite: Bool) {
        let iconName = isFavorite ? "heart.fill" : "heart"
        let iconConfig = UIImage.SymbolConfiguration(scale: UIImage.SymbolScale.small)
        let favoriteIcon = UIImage(systemName: iconName, withConfiguration: iconConfig)
        favoriteButton.setImage(favoriteIcon, for: .normal)
    }
}

// MARK: - @IBActions
extension ProductResultViewCell {
    @IBAction func toggleFavoriteTapped(_ sender: Any) {
        isFavorite ? deleteFavorite() : addFavorite()
        isFavorite = !isFavorite
    }
}
