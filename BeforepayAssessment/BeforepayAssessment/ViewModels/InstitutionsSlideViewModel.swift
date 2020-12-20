import UIKit

final class InstitutionsSlideViewModel {
    let clients: [Client]
    var expanded: Bool
    
    init(clients: [Client]) {
        self.clients = clients
        self.expanded = false
    }
}

// MARK: CarouselSlideViewModelProtocol Conformance

extension InstitutionsSlideViewModel: CarouselSlideViewModelProtocol {
    var slideTitle: String? {
        displayName
    }
    
    var cellViewModels: [CarouselSlideCellViewModelProtocol] {
        let clientsTotalIncome = clients.reduce(into: Decimal(0), { $0 = $0 + $1.totalBalance })
        return [self] + clients.map({
            ClientSummarySlideCellViewModel(
                client: $0,
                groupTotalIncome: clientsTotalIncome
            )
        })
    }
}

// MARK: CarouselSlideCellViewModelProtocol Conformance

extension InstitutionsSlideViewModel: CarouselSlideCellViewModelProtocol, DataFormatting {
    var displayName: String {
        "All accounts"
    }
    
    var icon: UIImage? {
        nil
    }
    
    var availableAmountString: String {
        formatCurrencyString(totalClientsBalance) ?? "--"
    }
    
    var availableAmountDescriptionString: String? {
        "Available balance"
    }
    
    var lastUpdatedString: String? {
        nil
    }
    
    var showSpendBadges: Bool {
        true
    }
    
    var spendViewModel: AmountViewModel? {
        formatCurrencyString(totalClientsSpend).map({
            .init(
                amount: $0,
                label: "Spent"
            )
        })
    }
    
    var incomeViewModel: AmountViewModel? {
        formatCurrencyString(totalClientsIncome).map({
            .init(
                amount: $0,
                label: "Income"
            )
        })
    }
    
    var balanceViewModel: BalanceBarViewModel? {
        let spent = totalClientsSpend / totalClientsBalance
        let income = totalClientsIncome / totalClientsBalance
        return .init(
            percentSpent: CGFloat(truncating: (spent as NSNumber)),
            percentIncome: CGFloat(truncating: (income as NSNumber))
        )
    }
    
    var customTheme: Theme? {
        BlueTheme()
    }
    
    // MARK: Private
    
    private var totalClientsBalance: Decimal {
        clients.reduce(into: Decimal(0), { $0 = $0 + $1.totalBalance })
    }
    
    private var totalClientsSpend: Decimal {
        clients.reduce(into: Decimal(0), { $0 = $0 + $1.totalSpend })
    }
    
    private var totalClientsIncome: Decimal {
        clients.reduce(into: Decimal(0), { $0 = $0 + $1.totalIncome })
    }
}
