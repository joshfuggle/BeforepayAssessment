import UIKit

struct BalanceBarViewModel {
    let percentSpent: CGFloat
    let percentIncome: CGFloat
}

final class BalanceBar: UIView {
    
    // MARK: Properties
    
    var theme: Theme
    var viewModel: BalanceBarViewModel? {
        didSet { bind() }
    }
    
    // MARK: Outlets
    
    private let stackView: UIStackView = .init()
    
    private let spentBar: GradientView = .init()
    private var spentWidth: NSLayoutConstraint? = nil
    
    private let incomeBar: GradientView = .init()
    private var incomeWidth: NSLayoutConstraint? = nil
    
    private let remainder: UIView = .init()
    
    init(theme: Theme) {
        self.theme = theme
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = theme.colorBalanceBarBackground
        layer.cornerRadius = theme.sizeXs
        layer.masksToBounds = true
        
        stackView.spacing = theme.sizeS
        fit(subview: stackView)
        
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalToConstant: theme.sizeS)
        ])
        
        stackView.backgroundColor = .clear
        
        spentBar.translatesAutoresizingMaskIntoConstraints = false
        spentBar.backgroundColor = theme.colorSpend
        spentBar.layer.cornerRadius = theme.sizeXs
        spentBar.layer.masksToBounds = true
        spentBar.viewModel = .init(leadingColor: theme.colorSpend, trailingColor: theme.colorSpendAlt, direction: .horizontal)
        
        incomeBar.translatesAutoresizingMaskIntoConstraints = false
        incomeBar.backgroundColor = theme.colorIncome
        incomeBar.layer.cornerRadius = theme.sizeXs
        incomeBar.layer.masksToBounds = true
        incomeBar.viewModel = .init(leadingColor: theme.colorIncome, trailingColor: theme.colorIncomeAlt, direction: .horizontal)
        
        remainder.translatesAutoresizingMaskIntoConstraints = false
        remainder.backgroundColor = .clear
    }
    
    private func bind() {
        // clear current state, if it exists
        spentBar.removeFromSuperview()
        incomeBar.removeFromSuperview()
        remainder.removeFromSuperview()
        
        spentWidth?.isActive = false
        incomeWidth?.isActive = false
        
        guard let viewModel = viewModel else { return }
        
        // set up new constraints
        let percentSpentMultiplier = viewModel.percentSpent
        let percentIncomeMultiplier = viewModel.percentIncome
        
        if percentSpentMultiplier > 0 {
            stackView.addArrangedSubview(spentBar)
            spentWidth = spentBar.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: percentSpentMultiplier)
            spentWidth?.priority = .required
            spentWidth?.isActive = true
        }
        
        if percentIncomeMultiplier > 0 {
            stackView.addArrangedSubview(incomeBar)
            incomeWidth = incomeBar.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: percentIncomeMultiplier)
            incomeWidth?.priority = .defaultHigh
            incomeWidth?.isActive = true
        }
        
        if (percentSpentMultiplier + percentIncomeMultiplier) < 1 {
            stackView.addArrangedSubview(remainder)
        }
    }
}
