import UIKit

protocol CarouselSlideViewModelProtocol {
    var slideTitle: String? { get }
    var expanded: Bool { get set }
    var cellViewModels: [CarouselSlideCellViewModelProtocol] { get }
    var customTheme: Theme? { get }
}

final class CarouselSlideViewController: UIViewController {
    
    // MARK: Properties
    
    var theme: Theme!
    var viewModel: CarouselSlideViewModelProtocol? {
        didSet { bind() }
    }
    
    // MARK: Outlets
    
    private let container: UIView = .init()
    private let mainStack: UIStackView = .init()
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: Private
    
    private func setup() {
        view.backgroundColor = theme.colorBackground
        
        container.layer.shadowColor = theme.colorShadow.cgColor
        container.layer.shadowRadius = theme.sizeXxl
        container.layer.shadowOpacity = 1
        container.layer.shadowOffset = CGSize(width: 0, height: 15)
        
        let containerBackground: GradientView = .init()
        containerBackground.viewModel = .init(leadingColor: theme.colorBackgroundCard, trailingColor: theme.colorBackgroundCardAlt, direction: .vertical)
        containerBackground.layer.cornerRadius = theme.sizeXl
        containerBackground.layer.borderWidth = 0
        containerBackground.layer.masksToBounds = true
        container.fit(subview: containerBackground)
        
        container.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(container)
        
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: theme.spacingL),
            container.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: theme.spacingL),
            container.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -theme.spacingL),
            container.bottomAnchor.constraint(lessThanOrEqualTo: safeArea.bottomAnchor, constant: -theme.spacingL),
        ])
        
        mainStack.axis = .vertical
        mainStack.spacing = theme.spacingL
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: container.topAnchor, constant: theme.spacingL),
            mainStack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: theme.spacingL),
            mainStack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -theme.spacingL),
            mainStack.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -theme.spacingL),
        ])
    }
    
    private func reload() {
        guard let viewModel = viewModel else { return }
        let expanded = viewModel.expanded
        let cellVMs = viewModel.cellViewModels
        
        func expandGesture() -> UITapGestureRecognizer {
            let tap: UITapGestureRecognizer = .init()
            tap.numberOfTapsRequired = 1
            tap.addTarget(self, action: #selector(expandTapped(_:)))
            return tap
        }
        
        mainStack.subviews.forEach({ $0.removeFromSuperview() })
        
        if expanded {
            for item in cellVMs.enumerated() {
                let view = CarouselSlideCellView(theme: theme)
                view.viewModel = item.element
                mainStack.addArrangedSubview(view)
                
                if item.offset < cellVMs.count - 1 {
                    mainStack.addArrangedSubview(SeparatorView(theme: theme))
                }
            }
            
        } else if let item = cellVMs.first {
            let view = CarouselSlideCellView(theme: theme)
            view.viewModel = item
            view.addGestureRecognizer(expandGesture())
            mainStack.addArrangedSubview(view)
        }
    }
    
    private func bind() {
        reload()
        navigationItem.title = viewModel?.slideTitle
    }
    
    // MARK: Actions
    
    @objc
    private func expandTapped(_ sender: UITapGestureRecognizer) {
        guard var vm = viewModel else { return }
        
        vm.expanded = true
        
        let slide = CarouselSlideViewController()
        slide.theme = theme
        slide.viewModel = viewModel
        
        navigationController?.pushViewController(slide, animated: true)
    }
    
}

