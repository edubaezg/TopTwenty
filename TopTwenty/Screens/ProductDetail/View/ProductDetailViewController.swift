import UIKit

class ProductDetailViewController: UIViewController {

    @IBOutlet weak var coverImageView: UIImageView! {
        didSet {
            coverImageView.layer.cornerRadius = 4
        }
    }
    
    @IBOutlet weak var favoriteButton: UIButton! {
        didSet {
            favoriteButton.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 14)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
    }
}

// MARK: - Methods
extension ProductDetailViewController {
    func setup() {
        title = "Detalle"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
    }
    
    func style() {
        view.backgroundColor = .white
    }
    
    func layout() {
        
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
