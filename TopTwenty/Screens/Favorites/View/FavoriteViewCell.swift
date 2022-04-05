import UIKit

// MARK: - FavoriteViewCell
class FavoriteViewCell: UITableViewCell {
    // MARK: - @IBOutlets
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
}

// MARK: - Initial Methods
extension FavoriteViewCell {
    func setup(product: Product) {
        priceLabel.text = String("$ \(product.price)")
        titleLabel.text = product.title
        thumbnailImageView.loadFrom(URLAddress: product.thumbnail)
        
        style()
    }
    
    func style() {
        thumbnailImageView.layer.cornerRadius = 4
    }
}
