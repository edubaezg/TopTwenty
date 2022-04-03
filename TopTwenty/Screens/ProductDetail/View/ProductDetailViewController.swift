import UIKit

class ProductDetailViewController: UIViewController {

    @IBOutlet weak var warrantyLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView! {
        didSet { coverImageView.layer.cornerRadius = 4 }
    }
    @IBOutlet weak var favoriteButton: UIButton! {
        didSet {
            favoriteButton.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 14)
        }
    }
    
    var product: Product
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
    }
    
    init(product: Product) {
        self.product = product
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        setProductView()
    }
    
    func style() {
        view.backgroundColor = .white
    }
    
    func layout() {
        
    }
}

// MARK: - Methods
extension ProductDetailViewController {
    func setProductView() {
        warrantyLabel.text = product.warranty ?? ""
        titleLabel.text = product.title
        coverImageView.loadFrom(URLAddress: product.pictures[0].url)
        priceLabel.text = "$ \(product.price)"
    }
}

// MARK: - Actions
extension ProductDetailViewController {
    @IBAction func toggleFavoriteTapped(_ sender: Any) {
        // TODO: Save favorite in local memory
        let favoriteIcon = UIImage(systemName: "heart.fill")
        favoriteButton.setImage(favoriteIcon, for: .normal)
        favoriteButton.setTitle("Quitar de favoritos", for: .normal)
    }
}
