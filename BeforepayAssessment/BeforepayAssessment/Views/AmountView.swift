import UIKit

struct AmountViewModel {
    let amount: String
    let label: String
}

final class AmountView: UIView {
    
    // MARK: Properties
    
    var theme: Theme
    var viewModel: AmountViewModel? {
        didSet { bind() }
    }
    
    var badgeColor: UIColor? {
        didSet {
            badgeView.backgroundColor = badgeColor
            badgeContainer.isHidden = badgeColor == nil
        }
    }
    
    // MARK: Outlets
    
    var stack: UIStackView = .init()
    let badgeContainer: UIView = .init()
    let badgeView: UIView = .init()
    let amountLabel: UILabel = .init()
    let purposeLabel: UILabel = .init()
    
    // MARK: Init
    
    init(theme: Theme) {
        self.theme = theme
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private
    
    private func setup() {
        stack.axis = .horizontal
        stack.spacing = theme.spacingXs
        fit(subview: stack)
        
        [badgeContainer, amountLabel, purposeLabel].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            stack.addArrangedSubview($0)
        })
        
        badgeView.translatesAutoresizingMaskIntoConstraints = false
        badgeContainer.addSubview(badgeView)
        NSLayoutConstraint.activate([
            badgeView.leadingAnchor.constraint(equalTo: badgeContainer.leadingAnchor),
            badgeView.trailingAnchor.constraint(equalTo: badgeContainer.trailingAnchor),
            badgeView.centerYAnchor.constraint(equalTo: badgeContainer.centerYAnchor),
            badgeView.heightAnchor.constraint(equalToConstant: theme.sizeS),
            badgeView.widthAnchor.constraint(equalToConstant: theme.sizeS),
        ])
        
        badgeView.layer.cornerRadius = (theme.sizeS / 2)
        badgeView.layer.masksToBounds = true
        
        amountLabel.font = theme.fontBodyBold
        amountLabel.textColor = theme.colorFontPrimary
        purposeLabel.font = theme.fontBody
        purposeLabel.textColor = theme.colorFontSecondary
    }
    
    private func bind() {
        amountLabel.text = viewModel?.amount
        purposeLabel.text = viewModel?.label
    }
    
}
