import UIKit

class NavigationStyleHelper {
    let navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func setNavigationBarStyle() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "primary")
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black, .font: UIFont.init(name: "HelveticaNeue", size: 18)!]

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}
