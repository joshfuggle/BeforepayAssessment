import UIKit

protocol CarouselViewModelProtocol {
    var slideViewModels: [CarouselSlideViewModelProtocol] { get }
}

final class CarouselViewController: UIViewController {
    
    // MARK: Outlets
    
    private var pageViewController: UIPageViewController = .init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    // MARK: Properties
    
    var theme: Theme = StandardTheme()
    var viewModel: CarouselViewModelProtocol? {
        didSet { bind() }
    }
    
    var viewControllers: [CarouselSlideViewController]? = nil
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: Private
    
    private func setup() {
        view.backgroundColor = theme.colorBackground
                
        addChild(pageViewController)
        view.fit(subview: pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        let appearance = UIPageControl.appearance(whenContainedInInstancesOf: [UIPageViewController.self])
        appearance.pageIndicatorTintColor = theme.colorPageControlTint
        appearance.currentPageIndicatorTintColor = theme.colorPageControlTintAlt
    }
    
    private func bind() {
        viewControllers = viewModel?.slideViewModels.map({
            let vc = CarouselSlideViewController()
            vc.theme = $0.customTheme ?? self.theme
            vc.viewModel = $0
            return vc
        })
        guard let firstVC = viewControllers?.first else { return }
        pageViewController.setViewControllers([firstVC], direction: .forward, animated: false, completion: nil)
    }
}

// MARK: UIPageViewControllerDelegate Conformance

extension CarouselViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let slideVC = viewController as? CarouselSlideViewController else { return nil }
        guard let currentIndex = viewControllers?.firstIndex(of: slideVC) else { return nil }
        let nextIndex = currentIndex - 1
        if nextIndex >= 0 {
            return viewControllers?[nextIndex]
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let slideVC = viewController as? CarouselSlideViewController else { return nil }
        guard let currentIndex = viewControllers?.firstIndex(of: slideVC) else { return nil }
        let nextIndex = currentIndex + 1
        if nextIndex < (viewControllers?.count ?? 0) {
            return viewControllers?[nextIndex]
        } else {
            return nil
        }
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        viewControllers?.count ?? 0
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let slideVC = pageViewController.viewControllers?.first as? CarouselSlideViewController else { return 0 }
        guard let currentIndex = viewControllers?.firstIndex(of: slideVC) else { return 0 }
        return currentIndex
    }
}
