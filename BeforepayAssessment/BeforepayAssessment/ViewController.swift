import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let baseTheme: Theme = StandardTheme()
        
        // Stylise the nav
        navigationItem.title = "Home"
        navigationItem.backButtonDisplayMode = .minimal
        
        let navigationBar = navigationController?.navigationBar
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        
        navigationBar?.tintColor = baseTheme.colorNavInteractive
        
        navigationBarAppearance.shadowColor = .clear
        navigationBarAppearance.backgroundColor = baseTheme.colorBackground
        
        navigationBar?.scrollEdgeAppearance = navigationBarAppearance
        navigationBar?.standardAppearance = navigationBarAppearance
        
        // Embed the carousel
        let carousel: CarouselViewController = .init()
        carousel.theme = baseTheme
        addChild(carousel)
        view.fit(subview: carousel.view)
        carousel.didMove(toParent: self)
        
        // Load the dummy content
        let cbaClient = InstitutionManager.shared.client(for: .commonwealthBank)
        let westpacClient = InstitutionManager.shared.client(for: .westpac)
        
        carousel.viewModel = CarouselViewModel(clients: [cbaClient, westpacClient])
    }
}

