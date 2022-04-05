import UIKit

// MARK: - ProductDetailViewController
class ProductDetailViewController: UIViewController {
    // MARK: - @IBOutlet
    @IBOutlet weak var warrantyLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView! {
        didSet { coverImageView.layer.cornerRadius = 4 }
    }
    @IBOutlet weak var favoriteButton: UIButton! {
        didSet { favoriteButton.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 14) }
    }
    
    // MARK: - Properties
    let productDetailViewModel = ProductDetailViewModel()
    var product: Product
    var isFavorite: Bool = false
    
    // MARK: - Inits
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
    }

    init(product: Product) {
        self.product = product
        self.isFavorite = product.isFavorite ?? false
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Initial Methods
extension ProductDetailViewController {
    func setup() {
        title = "Detalle"
        setProductDetailView()
    }
    
    func style() {
        view.backgroundColor = .white
    }
}

// MARK: - Methods
extension ProductDetailViewController {
    func setProductDetailView() {
        warrantyLabel.text = product.warranty ?? ""
        titleLabel.text = product.title
        coverImageView.loadFrom(URLAddress: product.pictures[0].url)
        priceLabel.text = "$ \(product.price)"
        setFavoriteButtonView(isFavorite: product.isFavorite ?? false)
    }
    
    func addFavorite() {
        productDetailViewModel.addFavorite(productId: product.id)
        setFavoriteButtonView(isFavorite: true)
    }
    
    func deleteFavorite() {
        productDetailViewModel.deleteFavorite(productId: product.id)
        setFavoriteButtonView(isFavorite: false)
    }
    
    func setFavoriteButtonView(isFavorite: Bool) {
        let buttonIconName = isFavorite ? "heart.fill" : "heart"
        let buttonIconImage = UIImage(systemName: buttonIconName)
        
        let title = isFavorite ? "Quitar de favoritos" : "Agregar a favoritos"
        let font = UIFont.systemFont(ofSize: 14)
        let attributes = [NSAttributedString.Key.font: font]
        let attributedQuote = NSAttributedString(string: title, attributes: attributes)
        
        favoriteButton.setAttributedTitle(attributedQuote, for: .normal)
        favoriteButton.setImage(buttonIconImage, for: .normal)
    }
    
}

// MARK: - Actions
extension ProductDetailViewController {
    @IBAction func toggleFavoriteTapped(_ sender: Any) {
        isFavorite ? deleteFavorite() : addFavorite()
        isFavorite = !isFavorite
    }
}
