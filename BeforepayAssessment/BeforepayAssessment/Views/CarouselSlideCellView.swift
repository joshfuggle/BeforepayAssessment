import UIKit

protocol CarouselSlideCellViewModelProtocol {
    var displayName: String { get }
    var icon: UIImage? { get }
    var availableAmountString: String { get }
    var availableAmountDescriptionString: String? { get }
    var lastUpdatedString: String? { get }
    var spendViewModel: AmountViewModel? { get }
    var incomeViewModel: AmountViewModel? { get }
    var showSpendBadges: Bool { get }
    var balanceViewModel: BalanceBarViewModel? { get }
}

final class CarouselSlideCellView: UIView {
    
    // MARK: Properties
    
    var theme: Theme = StandardTheme()
    var viewModel: CarouselSlideCellViewModelProtocol? {
        didSet { bind() }
    }
    
    // MARK: Outlets
    
    private let mainStack: UIStackView = .init()
    
    private let container1: UIView = .init()
    private let displayNameLabel: UILabel = .init()
    private let lastUpdatedLabel: UILabel = .init()
    
    private let container2: UIView = .init()
    private let availableAmountLabel: UILabel = .init()
    private let availableAmountDescriptionLabel: UILabel = .init()
    
    private let balanceBar: BalanceBar
    
    private let bottomContainer: UIView = .init()
    private var spendLabel: AmountView? = nil
    private var incomeLabel: AmountView? = nil
    
    // MARK: Init
    
    init(theme: Theme) {
        self.theme = theme
        self.balanceBar = BalanceBar(theme: theme)
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    
    private func setup() {
        let spendLabel: AmountView = .init(theme: theme)
        self.spendLabel = spendLabel
        
        let incomeLabel: AmountView = .init(theme: theme)
        self.incomeLabel = incomeLabel
        
        mainStack.axis = .vertical
        mainStack.spacing = theme.spacingXxl
        fit(subview: mainStack)
        
        [
            container1, displayNameLabel, lastUpdatedLabel,
            container2, availableAmountLabel, availableAmountDescriptionLabel,
            balanceBar,
            bottomContainer, spendLabel, incomeLabel
        ].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
        
        // row 1
        container1.addSubview(displayNameLabel)
        container1.addSubview(lastUpdatedLabel)
        NSLayoutConstraint.activate([
            displayNameLabel.leadingAnchor.constraint(equalTo: container1.leadingAnchor),
            displayNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: lastUpdatedLabel.leadingAnchor, constant: -theme.spacingS),
            lastUpdatedLabel.trailingAnchor.constraint(equalTo: container1.trailingAnchor),
            displayNameLabel.topAnchor.constraint(equalTo: container1.topAnchor),
            displayNameLabel.bottomAnchor.constraint(equalTo: container1.bottomAnchor),
            lastUpdatedLabel.topAnchor.constraint(equalTo: container1.topAnchor),
            lastUpdatedLabel.bottomAnchor.constraint(equalTo: container1.bottomAnchor)
        ])
        mainStack.addArrangedSubview(container1)
        displayNameLabel.font = theme.fontBodyBold
        displayNameLabel.textColor = theme.colorFontPrimary
        lastUpdatedLabel.font = theme.fontBody
        lastUpdatedLabel.textColor = theme.colorFontTernary
        
        // row 2
        container2.addSubview(availableAmountLabel)
        container2.addSubview(availableAmountDescriptionLabel)
        NSLayoutConstraint.activate([
            availableAmountLabel.leadingAnchor.constraint(equalTo: container2.leadingAnchor),
            availableAmountLabel.trailingAnchor.constraint(equalTo: availableAmountDescriptionLabel.leadingAnchor, constant: -theme.spacingS),
            availableAmountDescriptionLabel.trailingAnchor.constraint(lessThanOrEqualTo: container2.trailingAnchor),
            availableAmountLabel.topAnchor.constraint(equalTo: container2.topAnchor),
            availableAmountLabel.bottomAnchor.constraint(equalTo: container2.bottomAnchor),
            availableAmountDescriptionLabel.topAnchor.constraint(equalTo: container2.topAnchor),
            availableAmountDescriptionLabel.bottomAnchor.constraint(equalTo: container2.bottomAnchor)
        ])
        mainStack.addArrangedSubview(container2)
        availableAmountLabel.font = theme.fontTitle
        availableAmountLabel.textColor = theme.colorFontPrimary
        availableAmountDescriptionLabel.font = theme.fontBody
        availableAmountDescriptionLabel.textColor = theme.colorFontSecondary
        
        // row 3
        mainStack.addArrangedSubview(balanceBar)
        
        // row 4
        bottomContainer.addSubview(spendLabel)
        bottomContainer.addSubview(incomeLabel)
        NSLayoutConstraint.activate([
            spendLabel.leadingAnchor.constraint(equalTo: bottomContainer.leadingAnchor),
            spendLabel.trailingAnchor.constraint(lessThanOrEqualTo: incomeLabel.leadingAnchor, constant: -theme.spacingS),
            incomeLabel.trailingAnchor.constraint(equalTo: bottomContainer.trailingAnchor),
            spendLabel.topAnchor.constraint(equalTo: bottomContainer.topAnchor),
            spendLabel.bottomAnchor.constraint(equalTo: bottomContainer.bottomAnchor),
            incomeLabel.topAnchor.constraint(equalTo: bottomContainer.topAnchor),
            incomeLabel.bottomAnchor.constraint(equalTo: bottomContainer.bottomAnchor)
        ])
        mainStack.addArrangedSubview(bottomContainer)
        
    }
    
    private func bind() {
        displayNameLabel.text = viewModel?.displayName
        lastUpdatedLabel.text = viewModel?.lastUpdatedString
        lastUpdatedLabel.isHidden = viewModel?.lastUpdatedString == nil
        availableAmountLabel.text = viewModel?.availableAmountString
        availableAmountDescriptionLabel.text = viewModel?.availableAmountDescriptionString
        
        if let balanceViewModel = viewModel?.balanceViewModel {
            balanceBar.viewModel = balanceViewModel
            balanceBar.isHidden = false
        } else {
            balanceBar.isHidden = true
        }
        
        spendLabel?.viewModel = viewModel?.spendViewModel
        incomeLabel?.viewModel = viewModel?.incomeViewModel
        
        if viewModel?.showSpendBadges ?? false {
            spendLabel?.badgeColor = theme.colorSpend
            incomeLabel?.badgeColor = theme.colorIncome
        } else {
            spendLabel?.badgeColor = nil
            incomeLabel?.badgeColor = nil
        }
    }
}
