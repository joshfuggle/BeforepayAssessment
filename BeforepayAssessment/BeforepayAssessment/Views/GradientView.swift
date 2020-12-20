import UIKit

struct GradientViewModel {
    enum Direction {
        case vertical
        case horizontal
    }
    let leadingColor: UIColor
    let trailingColor: UIColor
    let direction: Direction
}

final class GradientView: UIView {
    
    var viewModel: GradientViewModel? {
        didSet { bind() }
    }
    
    private let gradientLayer: CAGradientLayer = .init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    private func setup() {
        gradientLayer.frame = bounds

        gradientLayer.locations = [0.0, 1.0]
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func bind() {
        guard let viewModel = viewModel else { return }
        gradientLayer.colors = [viewModel.leadingColor, viewModel.trailingColor].map({ $0.cgColor })
        
        switch viewModel.direction {
        case .horizontal:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        case .vertical:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        }
    }
}
